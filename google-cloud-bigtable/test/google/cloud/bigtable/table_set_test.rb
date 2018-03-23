# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'helper'
require 'google/cloud/bigtable/table_set'

describe Google::Cloud::Bigtable::TableSet do
  let(:project_id) {"project_#{Time.now.to_i}"}
  let(:config) {Google::Cloud::Bigtable::Config.new project_id}
  let(:table_set) {Google::Cloud::Bigtable::TableSet.new config, instance_id}
  let(:instance_id) {"instance_id_#{Time.now.to_i}"}

  describe '#initialize' do
    it 'should be Enumerable' do
      assert_includes Google::Cloud::Bigtable::TableSet.included_modules, Enumerable
    end
  end

  describe '#tables' do
    it 'should allow enumeration over empty set of instances' do
      response = OpenStruct.new tables: []
      mock_table_client = Minitest::Mock.new
      mock_table_client.expect :list_tables, response, [config.instance_path(instance_id), page_token: nil]

      table_set.stub(:client, mock_table_client) do
        assert_equal table_set.to_a.count, 0
      end

      mock_table_client.verify
    end

    it 'should allow enumeration over single page of instances' do
      table_objects = [OpenStruct.new(name: "Table#{Time.now.to_i}")]*10
      response = OpenStruct.new tables: table_objects
      mock_table_client = Minitest::Mock.new
      mock_table_client.expect :list_tables, response, [config.instance_path(instance_id), page_token: nil]

      table_set.stub(:client, mock_table_client) do
        ary = table_set.map { |m| m.name}.to_a
        assert_equal ary.count, table_objects.count
        table_objects.each do |ob|
          assert_includes ary, ob.name
        end
      end

      mock_table_client.verify
    end

    it 'should allow enumeration over multiple pages of instances' do
      token = "token_#{Time.now}"

      table_objects = [OpenStruct.new(name: "Table#{Time.now.to_i}")]*10
      response = OpenStruct.new tables: table_objects, next_page_token: token
      
      table_objects2 = [OpenStruct.new(name: "Table#{Time.now.to_i}")]*5
      response2 = OpenStruct.new tables: table_objects2, next_page_token: nil
      
      mock_table_client = Minitest::Mock.new
      mock_table_client.expect :list_tables, response, [config.instance_path(instance_id), page_token: nil]
      mock_table_client.expect :list_tables, response2, [config.instance_path(instance_id), page_token: token]

      table_set.stub(:client, mock_table_client) do
        ary = table_set.map { |m| m.name}.to_a
        assert_equal ary.count, 15
        table_objects.each do |ob|
          assert_includes ary, ob.name
        end
        table_objects2.each do |ob|
          assert_includes ary, ob.name
        end
      end

      mock_table_client.verify
    end


    it 'should break iteration if next_page_token is blank' do
      table_objects = [OpenStruct.new(name: "Table#{Time.now.to_i}")]*10
      response = OpenStruct.new tables: table_objects, next_page_token: ''
      mock_table_client = Minitest::Mock.new
      mock_table_client.expect :list_tables, response, [config.instance_path(instance_id), page_token: nil]

      table_set.stub(:client, mock_table_client) do
        ary = table_set.map { |m| m.name}.to_a
        assert_equal ary.count, table_objects.count
        table_objects.each do |ob|
          assert_includes ary, ob.name
        end
      end

      mock_table_client.verify
    end
  end
end
