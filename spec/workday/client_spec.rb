require 'spec_helper'

require 'webmock/rspec'

describe Workday::Client do
    let(:url){ 'https://i-0af1d538.workdaysuv.com/ccx/service/gms/Human_Resources/v19' }
    let(:headers){ {'Content-Type' => 'application/xml'} }
    let(:single_response_100){ File.read('spec/fixtures/get_workers/single_response_100.xml') }
    let(:paged_response_1){ File.read('spec/fixtures/get_workers/paged_response_1.xml') }
    let(:paged_response_2){ File.read('spec/fixtures/get_workers/paged_response_2.xml') }

    let(:client){ Workday::Client.new('user_name', 'password') }
    subject{client}

    it{ should be }
    describe "#initialize" do
        it "assigns a client" do
            subject.instance_variable_get(:@client).should be
        end

        it "assigns a logger" do
            subject.instance_variable_get(:@logger).should be
        end

        it "assigns a given logger" do
            logger = ::Logger.new STDERR
            client = Workday::Client.new 'user_name', 'password', logger: logger
            client.instance_variable_get(:@logger).should eq logger
        end
    end

    it{ should respond_to :get_workers }
    describe "#get_workers" do
        it "parses response into workers" do
            stub_request(:post, url).to_return(body: single_response_100, headers: headers)
            workers = subject.get_workers
            workers.size.should eq 100
        end

        it "handles multi-page responses" do
            stub_request(:post, url).with(body: /Page>1/).to_return(body: paged_response_1, headers: headers)
            stub_request(:post, url).with(body: /Page>2/).to_return(body: paged_response_2, headers: headers)
            workers = subject.get_workers
            workers.size.should eq 3
        end
    end

    describe "#process_response" do
        context "when given an invalid responses" do
            it "returns empty array when response is nil" do
                client.process_response(nil).should eq []
            end

            it "returns empty array when body is nil" do
                client.process_response(double("Response", :body => nil)).should eq []
            end

            it "returns empty array when get_workers_response is nil" do
                client.process_response(double("Response", :body => { :get_workers_response => nil })).should eq []
            end

            it "returns empty array when response_data is nil" do
                client.process_response(double("Response", :body => { :get_workers_response => { :response_data => nil } })).should eq []
            end

            it "returns empty array when workers is nil" do
                client.process_response(double("Response", :body => { :get_workers_response => { :response_data => { :workers => nil } } })).should eq []
            end
        end

        context "when given a valid response" do
            let(:workers){ ['first', 'second', 'third'] }
            let(:response){ double("Response", :body => { :get_workers_response => { :response_data => { :workers => workers } } }) }

            it "ensures result is an Array" do
                ResponseHelper.should_receive(:element_to_array).once
                client.process_response response
            end

            it "returns an array of elements" do
                client.process_response(response) =~ workers
            end
        end
    end

    describe "#process_worker_list" do
        it "calls process_worker_data for each worker" do
            workers = [{worker_data: 'first'}, {worker_data: 'second'}, {worker_data: 'third'}]
            client = Workday::Client.new('user_name', 'password')
            client.should_receive(:process_worker_data).exactly(3).times.and_return(Worker.new)
            client.process_worker_list workers
        end
    end

    describe "#process_worker_data" do
        it "calls Worker factory" do
            Worker.should_receive(:new_from_worker_data)
            subject.process_worker_data "some response"
        end

        it "logs error for failure" do
            Logger.any_instance.should_receive(:error).once
            Worker.should_receive(:new_from_worker_data).and_raise(StandardError, 'Testing Errors')
            subject.process_worker_data "some response"
        end
    end
end
