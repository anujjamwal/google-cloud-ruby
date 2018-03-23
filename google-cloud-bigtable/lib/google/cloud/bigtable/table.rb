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

module Google
  module Cloud
    module Bigtable
      class Table
        attr_reader :name, :column_families, :granularity

        def initialize name: nil, column_families: nil, granularity: :MILLIS
          @name = name
          @column_families = column_families
          @granularity = granularity          
        end

        # builds a table object from ProtoBuf object. The method is mostly
        # for internal usage.
        # @param proto_ob [Google::Bigtable::Admin::V2::Table]
        # @param client [Google::Cloud::Bigtable::Client]
        # @return [Google::Cloud::Bigtable::Table]
        def self.from_proto_ob proto_ob, client
          table = Table.new name: proto_ob.name,
                               column_families: proto_ob.column_families.to_h,
                               granularity: proto_ob.granularity
          table.send :client=, client
          table
        end

        private
        attr_writer :client
        attr_reader :client
      end
    end
  end
end
