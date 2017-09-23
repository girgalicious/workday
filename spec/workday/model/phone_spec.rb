require 'spec_helper'

describe Workday::Phone do
    %w( type number ).each do |attribute|
        it{ should have_attribute attribute }
    end

    describe ".new_from_phone_data" do
        let(:phone_home){ Workday::Phone.new type: 'HOME', description: 'Home', number: '+1 (415) 441-7842' }
        let(:phone_work){ Workday::Phone.new type: 'WORK', description: 'Work', number: '+1 (415) 789-8904' }

        let(:phone_data_one_phone_number){
            {
                :country_iso_code => "USA",
                :international_phone_code => "1",
                :area_code => "415",
                :phone_number => "789-8904",
                :phone_device_type_reference => {
                    :id => ["d691375437c848aea9d5b0874353bfd7", "1063.1"],
                    :"@wd:descriptor" => "Mobile"
                },
                :usage_data => {
                    :type_data => {
                        :type_reference => {
                            :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
                            :"@wd:descriptor" => "Work"
                        },
                        :"@wd:primary" => "1"
                    },
                    :"@wd:public" => "1"
                },
                :"@wd:formatted_phone" => "+1 (415) 789-8904",
            }
        }

        let(:phone_data_multiple_phone_numbers){
            [
                {
                    :country_iso_code => "USA",
                    :international_phone_code => "1",
                    :area_code => "415",
                    :phone_number => "441-7842",
                    :phone_device_type_reference => {
                        :id => ["3014da0ed66f41a3b88085b19175300e", "1063.5"],
                        :"@wd:descriptor" => "Telephone"
                    },
                    :usage_data => {
                        :type_data => {
                            :type_reference => {
                                :id => ["836cf00ef5974ac08b786079866c946f", "HOME"],
                                :"@wd:descriptor" => "Home"
                            },
                            :"@wd:primary" => "0"
                        },
                        :"@wd:public" => "0"
                    },
                    :"@wd:formatted_phone" => "+1 (415) 441-7842",
                },
                {
                    :country_iso_code => "USA",
                    :international_phone_code => "1",
                    :area_code => "415",
                    :phone_number => "789-8904",
                    :phone_device_type_reference => {
                        :id => ["d691375437c848aea9d5b0874353bfd7", "1063.1"],
                        :"@wd:descriptor" => "Mobile"
                    },
                    :usage_data => {
                        :type_data => {
                            :type_reference => {
                                :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
                                :"@wd:descriptor" => "Work"
                            },
                            :"@wd:primary" => "1"
                        },
                        :"@wd:public" => "1"
                    },
                    :"@wd:formatted_phone" => "+1 (415) 789-8904",
                }
            ]
        }

        context "when response has a single phone number" do
            it "returns a Hash with the phone number" do
                expected_phones = { 'WORK' => phone_work }
                phones = Workday::Phone.new_from_phone_data phone_data_one_phone_number
                phones.should eq expected_phones
            end
        end

        context "when response has multiple phone numbers" do
            it "returns a Hash with the phone numbers" do
                expected_phones = { 'HOME' => phone_home, 'WORK' => phone_work }
                phones = Workday::Phone.new_from_phone_data phone_data_multiple_phone_numbers
                phones.should eq expected_phones
            end
        end
    end
end
