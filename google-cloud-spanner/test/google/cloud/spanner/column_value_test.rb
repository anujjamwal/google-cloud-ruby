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

require "helper"

describe Google::Cloud::Spanner::ColumnValue do
  it "creates an commit_timestamp" do
    column_value = Google::Cloud::Spanner::ColumnValue.commit_timestamp

    column_value.must_be_kind_of Google::Cloud::Spanner::ColumnValue
    column_value.type.must_equal :commit_timestamp
    column_value.to_column_value.must_equal "spanner.commit_timestamp()"
  end
end
