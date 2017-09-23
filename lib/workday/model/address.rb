module Workday
    class Address
        include Virtus::ValueObject

        attribute :type, String
        attribute :description, String
        attribute :lines, Array[String]
        attribute :city, String
        attribute :state, String
        attribute :postal_code, String
        attribute :country, String

        # Returns a Hash of Address objects parsed from the given Workday response
        def self.new_from_address_data response
            addresses = {}

            Workday.response_to_array(response).each do |address_data|
                address = get_address_from_data address_data
                addresses[address.type] = address
            end

            addresses
        end

        private

        def self.get_address_from_data address_data
            Address.new(
                type: address_data[:usage_data][:type_data][:type_reference][:id][1],
                description: address_data[:usage_data][:type_data][:type_reference][:"@wd:descriptor"],
                lines: address_data[:address_line_data].is_a?(Array) ? address_data[:address_line_data] : [address_data[:address_line_data]],
                city: address_data[:municipality],
                state: address_data[:country_region_reference] ? address_data[:country_region_reference][:id][1][/\w+-(\w+)/,1] : nil,
                postal_code: address_data[:postal_code],
                country: address_data[:country_reference][:id][2]
            )
        end
    end
end
