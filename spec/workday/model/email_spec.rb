require 'spec_helper'

describe Workday::Email do
    # %w( type email ).each do |attribute|
    #     it{ should have_attribute attribute }
    # end

    # describe ".new_from_email_address_data" do
    #     let(:email_home){ Workday::Email.new type: 'HOME', description: 'Home', email: 'clay.christensen@workday.com' }
    #     let(:email_work){ Workday::Email.new type: 'WORK', description: 'Work', email: 'clay.christensen@workday.com' }

    #     let(:email_address_data_one_email){
    #         {
    #             :email_address => "clay.christensen@workday.com",
    #             :usage_data => {
    #                 :type_data => {
    #                     :type_reference => {
    #                         :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
    #                         :"@wd:descriptor" => "Work"
    #                     },
    #                     :"@wd:primary" => "1"
    #                 },
    #                 :"@wd:public" => "1"
    #             }
    #         }
    #     }

    #     let(:email_address_data_multiple_emails){
    #         [
    #             {
    #                 :email_address => "clay.christensen@workday.com",
    #                 :usage_data => {
    #                     :type_data => {
    #                         :type_reference => {
    #                             :id => ["836cf00ef5974ac08b786079866c946f", "HOME"],
    #                             :"@wd:descriptor" => "Home"
    #                         },
    #                         :"@wd:primary" => "0"
    #                     },
    #                     :"@wd:public" => "0"
    #                 }
    #             },
    #             {
    #                 :email_address => "clay.christensen@workday.com",
    #                 :usage_data => {
    #                     :type_data => {
    #                         :type_reference => {
    #                             :id => ["1f27f250dfaa4724ab1e1617174281e4", "WORK"],
    #                             :"@wd:descriptor" => "Work"
    #                         },
    #                         :"@wd:primary" => "1"
    #                     },
    #                     :"@wd:public" => "1"
    #                 }
    #             }
    #         ]
    #     }

    #     context "when response has a single email address" do
    #         it "returns a Hash with the email address" do
    #             expected_emails = { 'WORK' => email_work }
    #             emails = Workday::Email.new_from_email_address_data email_address_data_one_email
    #             emails.should eq expected_emails
    #         end
    #     end

    #     context "when response has multiple email addresses" do
    #         it "returns a Hash with the email addresses" do
    #             expected_emails = { 'HOME' => email_home, 'WORK' => email_work }
    #             emails = Workday::Email.new_from_email_address_data email_address_data_multiple_emails
    #             emails.should eq expected_emails
    #         end
    #     end
    # end
end
