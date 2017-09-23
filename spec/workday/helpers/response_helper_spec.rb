require 'spec_helper'
require 'workday'

describe Workday::ResponseHelper do
    describe ".element_to_array" do
        it "returns a single element as an array" do
            element = 'foobar'
            result = ResponseHelper.element_to_array element
            result.should be_kind_of(Array)
            result.size.should eq 1
            result.should include(element)
        end

        it "returns an array as itself" do
            element = ['foobar']
            result = ResponseHelper.element_to_array element
            result.should eq element
        end

        it "returns an empty array for nil" do
            result = ResponseHelper.element_to_array nil
            result.should eq []
        end
    end
end
