module Workday
    class Phone
        include Virtus::ValueObject

        attribute :type, String
        attribute :description, String
        attribute :number, String

        # Returns a Hash of Phone objects parsed from the given Workday response
        def self.new_from_phone_data response
            phones = {}

            Workday.response_to_array(response).each do |phone_data|
                phone = get_phone_from_data phone_data
                phones[phone.type] = phone
            end

            phones
        end

        private

        def self.get_phone_from_data phone_data
            Phone.new(
                type: phone_data[:usage_data][:type_data][:type_reference][:id][1],
                description: phone_data[:usage_data][:type_data][:type_reference][:"@wd:descriptor"],
                number: phone_data[:"@wd:formatted_phone"]
            )
        end
    end
end
