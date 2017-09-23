module Workday
    class Email
        include Virtus::ValueObject

        attribute :type, String
        attribute :description, String
        attribute :email, String

        # Returns a Hash of Email objects parsed from the given Workday response
        def self.new_from_email_address_data response
            emails = {}

            Workday.response_to_array(response).each do |email_data|
                email = get_email_from_data email_data
                emails[email.type] = email
            end

            emails
        end

        private

        def self.get_email_from_data email_data
            Email.new(
                type: email_data[:usage_data][:type_data][:type_reference][:id][1],
                description: email_data[:usage_data][:type_data][:type_reference][:"@wd:descriptor"],
                email: email_data[:email_address]
            )
        end
    end
end
