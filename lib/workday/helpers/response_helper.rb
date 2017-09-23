module Workday
    class ResponseHelper

        # If the XML response has more than one element, it'll be an Array.
        # If it has just one element, then it will not be an Array.
        # This method will take either case and will always return an Array.
        def self.element_to_array element
            return [] if element.nil?
            element.is_a?(Array) ? element : [element]
        end

    end
end
