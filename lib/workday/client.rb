require 'logger'
require 'savon'

module Workday
    class Client
        def initialize(credentials, options = {})
            
            options[:wsdl] = File.expand_path('lib/workday/assets/Human_Resources.wsdl') if !options[:wsdl]
            options[:wsse_auth] = [credentials[:username], credentials[:password]]

            options[:log_level] = :error if !options[:log_level]
            options[:pretty_print_xml] = true if !options[:pretty_print_xml]

            @wsdl = options[:wsdl] || File.dirname(__FILE__) + '/../../resources/partner.wsdl.xml'

            @host = options[:host] || "wd5-impl-services1.workday.com"
            @login_url = options[:login_url] || "https://#{@host}/ccx/service/#{credentials[:tenant]}/Human_Resources"
            
            @logger = options[:logger] || false

            # Override optional Savon attributes
            savon_options = {}
            %w(read_timeout open_timeout proxy raise_errors).each do |prop|
                key = prop.to_sym
                savon_options[key] = options[key] if options.key?(key)
            end
            
            @client = Savon.client(options)
        end
        
        # Public: Get the names of all wsdl operations.
        # List all available operations from the Human_Resources.wsdl
        
        def operations
            @client.operations
        end

        def get_workers params = {}
            workers = do_get_workers params
            @logger.debug("Workday:  Retreieved #{workers.size} workers from response.")
            workers
        end

        def process_response response
            if response &&
               response.body &&
               response.body[:get_workers_response] &&
               response.body[:get_workers_response][:response_data]
                return ResponseHelper.element_to_array response.body[:get_workers_response][:response_data][:worker]
            end
            []
        end

        def process_worker_list worker_list
            workers = []

            worker_list.each do |worker|
                worker = process_worker_data worker[:worker_data]
                workers << worker if worker
            end

            workers
        end

        def process_worker_data worker_data
            begin
                Worker.new_from_worker_data worker_data
            rescue StandardError => e
                @logger.error "Unable to process worker record:  #{e}\n#{worker_data}"
            end
        end

        private

        def do_get_workers params = {}
            workers = []

            # For multi-page responses, the As_Of_Entry_DateTime anchors the pages
            params[:page] = 1 if !params[:page]
            params[:as_of_entry_datetime] = DateTime.now if !params[:as_of_entry_datetime]

            response = get_workers_call params
            if response
                worker_list = ResponseHelper.element_to_array response.body[:get_workers_response][:response_data][:worker]
                page = response.body[:get_workers_response][:response_results][:page]
                total_pages = response.body[:get_workers_response][:response_results][:total_pages]

                @logger.debug("Workday:  Processing page #{page} of #{total_pages} total pages.")
                worker_list.each do |worker|
                    worker = process_worker_data worker[:worker_data]
                    workers << worker if worker
                end

                # Recurse if more pages in the results
                if page < total_pages
                    params[:page] = params[:page] + 1
                    workers << do_get_workers(params)
                end
            end

            workers
        end

        def get_workers_call params = {}
            @logger.debug "Workday:  Sending Get_Workers request.  Params = #{params}"
            @client.call :get_workers, get_workers_params(params)
        end

        def get_workers_params params = {}
            {
                message_tag: :Get_Workers_Request,
                message: get_workers_message(params),
                attributes: { "bsvc:version" => "v19" }
            }
        end

        def get_workers_message params = {}
            message = {}
            message.merge! get_response_filter(params)
            message.merge! get_response_group
            message
        end

        def get_response_filter params = {}
            filter = {}

            filter["Page"] = params[:page] if params[:page]
            filter["Count"] = params[:count] if params[:count]
            filter["As_Of_Effective_Date"] = params[:as_of_effective_date] if params[:as_of_effective_date]
            filter["As_Of_Entry_DateTime"] = params[:as_of_entry_datetime] if params[:as_of_entry_datetime]

            { "bsvc:Response_Filter" => filter }
        end

        def get_response_group
            { "bsvc:Response_Group" => {
                "Include_Personal_Information" => true,
                "Include_Employment_Information" => true
            } }
        end

    end
end
