require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::CustomFields do
  before do
    @client = create_client
  end

  describe "query" do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <result>
          <total_results>3</total_results>
          <customField>
            <id>12345</id>
            <field_id>One_Custom_Field</field_id>
            <name>One Custom Field</name>
            <type>Text</type>
            <type_id>1</type_id>
          </customField>
          <customField>
            <id>54321</id>
            <field_id>Another_Custom_Field</field_id>
            <name>Another Custom Field</name>
            <type>Number</type>
            <type_id>8</type_id>
          </customField>
          <customField>
            <id>13579</id>
            <field_id>Last_Custom_Field</field_id>
            <name>Last Custom Field</name>
            <type>Text</type>
            <type_id>1</type_id>
          </customField>
        </result>
      </rsp>)
    end

    it "should take in some arguments" do
      fake_get "/api/customField/version/3/do/query?id_less_than=1000&user_key=bar&api_key=my_api_key&format=simple", sample_results

      @client.custom_fields.query(:id_less_than => 1000).should == {"total_results" => 3,
        "customField"=>[
          {"id"=>"12345", "field_id" => "One_Custom_Field", "name"=>"One Custom Field", "type" => "Text", "type_id" => "1"},
          {"id"=>"54321", "field_id" => "Another_Custom_Field", "name"=>"Another Custom Field", "type" => "Number", "type_id" => "8"},
          {"id"=>"13579", "field_id" => "Last_Custom_Field", "name"=>"Last Custom Field", "type" => "Text", "type_id" => "1"},
        ]}
    end
  end

  describe "create" do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <customField>
          <id>202</id>
          <field_id>New_Field</field_id>
          <name>New Field</name>
          <type>Text</type>
          <type_id>1</type_id>
        </customField>
      </rsp>)
    end

    it "should return the created custom field" do
      fake_post "/api/customField/version/3/do/create?name=New%20Field&field_id=New_Field&user_key=bar&api_key=my_api_key&format=simple", sample_results

      @client.custom_fields.create(:name => 'New Field', :field_id => 'New_Field').should == {
        "id" => "202",
        "field_id" => "New_Field",
        "name" => "New Field",
        "type" => "Text",
        "type_id" => "1"
      }
    end
  end

  describe "read_by_id" do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <customField>
          <id>202</id>
          <field_id>Read_Field</field_id>
          <name>Read Field</name>
          <type>Text</type>
          <type_id>1</type_id>
        </customField>
      </rsp>)
    end

    it "should return the custom field" do
      fake_get "/api/customField/version/3/do/read/id/202?user_key=bar&api_key=my_api_key&format=simple", sample_results

      @client.custom_fields.read_by_id(202).should == {
        "id" => "202",
        "field_id" => "Read_Field",
        "name" => "Read Field",
        "type" => "Text",
        "type_id" => "1"
      }
    end
  end

  describe "update_by_id" do
    def sample_results
      %(<?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok" version="1.0">
        <customField>
          <id>202</id>
          <field_id>Old_Field</field_id>
          <name>New Field</name>
          <type>Text</type>
          <type_id>1</type_id>
        </customField>
      </rsp>)
    end

    it "should return the updated custom field" do
      fake_post "/api/customField/version/3/do/update/id/202?name=New%20Field&field_id=Old_Field&type=Text&type_id=1&user_key=bar&api_key=my_api_key&format=simple", sample_results

      @client.custom_fields.update_by_id(202, :name => 'New Field', :field_id => "Old_Field", :type => "Text", :type_id => 1).should == {
        "id" => "202",
        "field_id" => "Old_Field",
        "name" => "New Field",
        "type" => "Text",
        "type_id" => "1"
      }
    end
  end
end
