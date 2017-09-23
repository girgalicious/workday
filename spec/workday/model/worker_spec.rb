require 'spec_helper'
require 'workday'

describe Workday::Worker do
    %w( employee_id first_name last_name hire_date addresses phones emails ).each do |attribute|
        it{ should have_attribute attribute }
    end

    describe ".new_from_worker_data" do
        let(:expected_worker){
            Workday::Worker.new(
                employee_id: '21001',
                first_name: 'Logan',
                last_name: 'McNeil',
                hire_date: '2000-01-01-08:00'
            )
        }

        let(:worker_data){
            {
                :worker_id => "21001",
                :personal_data => {
                    :name_data => {
                        :legal_name_data => {
                            :name_detail_data => {
                                :first_name => "Logan",
                                :last_name => "McNeil"
                            }
                        }
                    },
                    :contact_data => {
                        :address_data => [
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
                            }
                        ],
                        :email_address_data => [
                            {
                                :email_address => "clay.christensen@workday.com",
                                :usage_data => {
                                    :type_data => {
                                        :type_reference => {
                                            :id => ["836cf00ef5974ac08b786079866c946f", "HOME"],
                                            :"@wd:descriptor" => "Home"
                                        },
                                        :"@wd:primary" => "0"
                                    },
                                    :"@wd:public" => "0"
                                }
                            },
                            {
                                :email_address => "clay.christensen@workday.com",
                                :usage_data => {
                                    :type_data => {
                                        :type_reference => {
                                            :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
                                            :"@wd:descriptor" => "Work"
                                        },
                                        :"@wd:primary" => "1"
                                    },
                                    :"@wd:public" => "1"
                                }
                            }
                        ],
                        :phone_data => [
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
                },
                :employment_data => {
                    :worker_status_data => {
                        :hire_date => Date.parse("2000-01-01-08:00")
                    }
                }
            }
        }

        let(:email_home){ Workday::Email.new type: 'HOME', description: 'Home', email: 'clay.christensen@workday.com' }
        let(:email_work){ Workday::Email.new type: 'WORK', description: 'Work', email: 'clay.christensen@workday.com' }
        let(:expected_emails){ { :HOME => email_home, :WORK => email_work } }

        let(:phone_home){ Workday::Phone.new type: 'HOME', description: 'Home', number: '+1 (415) 441-7842' }
        let(:phone_work){ Workday::Phone.new type: 'WORK', description: 'Work', number: '+1 (415) 789-8904' }
        let(:expected_phones){ { :HOME => phone_home, :WORK => phone_work } }

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
        let(:expected_addresses){ { :HOME => address_home, :WORK => address_work } }

        it "returns a Worker" do
            worker = Workday::Worker.new_from_worker_data worker_data

            # When Virtus releases a fix for ValueObjects with Hashes, the follow can
            # be replaced with the simple "should eq" test
            # worker.should eq expected_worker

            worker.employee_id.should eq expected_worker.employee_id
            worker.first_name.should eq expected_worker.first_name
            worker.last_name.should eq expected_worker.last_name
            worker.hire_date.should eq expected_worker.hire_date

            worker.addresses.should eq expected_addresses
            worker.emails.should eq expected_emails
            worker.phones.should eq expected_phones
        end

        describe 'calls other model factories' do
            it "calls the Email factory" do
                Email.should_receive(:new_from_email_address_data)
                Workday::Worker.new_from_worker_data worker_data
            end

            it "calls the Address factory" do
                Address.should_receive(:new_from_address_data)
                Workday::Worker.new_from_worker_data worker_data
            end

            it "calls the Phone factory" do
                Phone.should_receive(:new_from_phone_data)
                Workday::Worker.new_from_worker_data worker_data
            end
        end
    end
end
