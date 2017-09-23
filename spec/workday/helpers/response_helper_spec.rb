require 'spec_helper'
require 'workday'

describe Workday::ResponseHelper do
    
    describe ".element_to_array" do
        it "returns a single element as an array" do
            element = 'foobar'
            result = ResponseHelper.element_to_array element
            
            expect(result).to be_kind_of(Array)
            expect(result.size).to eq 1
            expect(result).to include(element)
        end

        it "returns an array as itself" do
            element = ['foobar']
            result = ResponseHelper.element_to_array element
            
            expect(result).to eq element
        end

        it "returns an empty array for nil" do
            result = ResponseHelper.element_to_array nil
            
            expect(result).to eq []
        end
    end
end
