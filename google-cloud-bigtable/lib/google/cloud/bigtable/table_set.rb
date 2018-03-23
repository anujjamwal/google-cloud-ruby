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

require "google/cloud/bigtable/admin/v2"
require "google/cloud/bigtable/table"

module Google
  module Cloud
    module Bigtable
      class TableSet
        include Enumerable

        def initialize config, instance_id
          @config = config
          @instance_id = instance_id
        end

        # each method for Enumerable interface. the method fetches and yields
        # BigTable Table objects.
        # @example
        #   # object can be used as a ruby enumerable.
        #   names = tables.collect(:name).to_a
        def each
          page_token = nil
          loop do
            response = client.list_tables @config.instance_path(@instance_id),
                                            page_token: page_token
            response.tables.each do |instance|
              yield Bigtable::Table.from_proto_ob instance, client
            end

            page_token = response.next_page_token
            break if page_token.nil? || page_token.empty?
          end
        end

        # Create or return bigtable instance admin client
        # @return [Google::Cloud::Bigtable::Admin::V2::BigtableTableAdminClient]
        def client
          @client ||= begin
            Google::Cloud::Bigtable::Admin::V2::BigtableInstanceAdmin.new(
              @config.admin_credentials
            )
          end
        end
      end
    end
  end
end
