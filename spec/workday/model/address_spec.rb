require 'spec_helper'

describe Workday::Address do
    %w( type lines city state postal_code country ).each do |attribute|
        it{ should have_attribute attribute }
    end

    describe ".new_from_address_data" do
        let(:address_home){
            Workday::Address.new(
                type: 'HOME',
                description: 'Home',
                lines: ['42 Laurel Street'],
                city: 'San Francisco',
                state: 'CA',
                postal_code: '94118',
                country: 'USA'
            )
        }

        let(:address_work){
            Workday::Address.new(
                type: 'WORK',
                description: 'Work',
                lines: ['3939 The Embarcadero'],
                city: 'San Francisco',
                state: 'CA',
                postal_code: '94118',
                country: 'USA'
            )
        }

        let(:address_data_one_address){
            {
                :country_reference => {
                    :id => [
                        "bc33aa3152ec42d4995f4791a106ed09",
                        "US",
                        "USA",
                        "840"
                    ],
                    :"@wd:descriptor" => "United States of America"
                },
                :address_line_data => "42 Laurel Street",
                :municipality => "San Francisco",
                :country_region_reference => {
                    :id => ["ec3d210e4240442e99a28fa70419aec5", "USA-CA"],
                    :"@wd:descriptor" => "California"
                },
                :postal_code => "94118",
                :usage_data => {
                    :type_data => {
                        :type_reference => {
                            :id => ["836cf00ef5974ac08b786079866c946f", "HOME"],
                            :"@wd:descriptor" => "Home"
                        },
                        :"@wd:primary" => "1"
                    },
                    :"@wd:public" => "0"
                },
                :address_reference => {
                    :id => ["91d468fd9c3b465f86ed1362f06b3c5b", "ADDRESS_REFERENCE-4-1"],
                    :"@wd:descriptor" => "ADDRESS_REFERENCE-4-1"
                },
                :"@wd:effective_date" => "2008-03-25-07:00",
                :"@wd:address_format_type" => "Basic",
                :"@wd:formatted_address" => "42 Laurel Street&#xa;San Francisco, CA 94118&#xa;United States of America",
                :"@wd:defaulted_business_site_address" => "0"
            }
        }

        let(:address_data_multiple_addresses){
            [
                {
                    :country_reference => {
                        :id => [
                            "bc33aa3152ec42d4995f4791a106ed09",
                            "US",
                            "USA",
                            "840"
                        ],
                        :"@wd:descriptor" => "United States of America"
                    },
                    :address_line_data => "42 Laurel Street",
                    :municipality => "San Francisco",
                    :country_region_reference => {
                        :id => ["ec3d210e4240442e99a28fa70419aec5", "USA-CA"],
                        :"@wd:descriptor" => "California"
                    },
                    :postal_code => "94118",
                    :usage_data => {
                        :type_data => {
                            :type_reference => {
                                :id => ["836cf00ef5974ac08b786079866c946f", "HOME"],
                                :"@wd:descriptor" => "Home"
                            },
                            :"@wd:primary" => "1"
                        },
                        :"@wd:public" => "0"
                    },
                    :address_reference => {
                        :id => ["91d468fd9c3b465f86ed1362f06b3c5b", "ADDRESS_REFERENCE-4-1"],
                        :"@wd:descriptor" => "ADDRESS_REFERENCE-4-1"
                    },
                    :"@wd:effective_date" => "2008-03-25-07:00",
                    :"@wd:address_format_type" => "Basic",
                    :"@wd:formatted_address" => "42 Laurel Street&#xa;San Francisco, CA 94118&#xa;United States of America",
                    :"@wd:defaulted_business_site_address" => "0"
                },
                {
                    :country_reference => {
                        :id => [
                            "bc33aa3152ec42d4995f4791a106ed09",
                            "US",
                            "USA",
                            "840"
                        ],
                        :"@wd:descriptor" => "United States of America"
                    },
                    :address_line_data => "3939 The Embarcadero",
                    :municipality => "San Francisco",
                    :country_region_reference => {
                        :id => ["ec3d210e4240442e99a28fa70419aec5", "USA-CA"],
                        :"@wd:descriptor" => "California"
                    },
                    :postal_code => "94118",
                    :usage_data => {
                        :type_data => {
                            :type_reference => {
                                :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
                                :"@wd:descriptor" => "Work"
                            },
                            :"@wd:primary" => "0"
                        },
                        :"@wd:public" => "1"
                    },
                    :address_reference => {
                        :id => ["d77b39b882ec495daed85c9f94876283", "ADDRESS_REFERENCE-4-640"],
                        :"@wd:descriptor" => "ADDRESS_REFERENCE-4-640"
                    },
                    :"@wd:effective_date" => "2000-01-01-08:00",
                    :"@wd:address_format_type" => "Basic",
                    :"@wd:formatted_address" => "3939 The Embarcadero&#xa;San Francisco, CA 94111&#xa;United States of America",
                    :"@wd:defaulted_business_site_address" => "1"
                },
            ]
        }

        context "when response has a single address number" do
            it "returns a Hash with the address number" do
                expected_addresses = { 'HOME' => address_home }
                address = Workday::Address.new_from_address_data address_data_one_address
                address.should eq expected_addresses
            end
        end

        context "when response has multiple address numbers" do
            it "returns a Hash with the address numbers" do
                expected_addresses = { 'HOME' => address_home, 'WORK' => address_work }
                address = Workday::Address.new_from_address_data address_data_multiple_addresses
                address.should eq expected_addresses
            end
        end

        context "when address doesn't have a state" do
            let(:no_state_address){
                {
                    :country_reference => {
                        :id => [
                            "80938777cac5440fab50d729f9634969",
                            "SG",
                            "SGP",
                            "702"
                        ],
                        :"@wd:descriptor" => "Singapore"
                    },
                    :address_line_data => "Temasek Boulevard",
                    :municipality => "Singapore",
                    :postal_code => "038985",
                    :usage_data => {
                        :type_data => {
                            :type_reference => {
                                :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
                                :"@wd:descriptor" => "Work"
                            },
                            :"@wd:primary" => "0"
                        },
                        :"@wd:public" => "1"
                    },
                    :address_reference => {
                        :id => ["bb335048b5dd4047b9329d99160a4ee8", "ADDRESS_REFERENCE-4-650"],
                        :"@wd:descriptor" => "ADDRESS_REFERENCE-4-650"
                    },
                    :"@wd:effective_date" => "2000-01-01-08:00",
                    :"@wd:address_format_type" => "Basic",
                    :"@wd:formatted_address" => "1 Fort Road&amp;#xa;Unit 75&amp;#xa;Singapore 427665&amp;#xa;Singapore",
                    :"@wd:defaulted_business_site_address" => "0"
                }
            }

            it "leaves state blank" do
                expected = { 'WORK' => Workday::Address.new(
                    type: 'WORK',
                    description: 'Work',
                    lines: ['Temasek Boulevard'],
                    city: 'Singapore',
                    state: nil,
                    postal_code: '038985',
                    country: 'SGP'
                ) }
                address = Workday::Address.new_from_address_data no_state_address
                address.should eq expected
            end
        end
    end
end
