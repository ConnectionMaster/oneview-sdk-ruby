# (C) Copyright 2020 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require 'spec_helper'

RSpec.describe OneviewSDK::API1600::C7000::HypervisorClusterProfile do
  include_context 'shared context'

  it 'inherits from OneviewSDK::API1200::C7000::HypervisorClusterProfile' do
    expect(described_class).to be < OneviewSDK::API1200::C7000::HypervisorClusterProfile
  end

  describe '#delete' do
    it 'passes no extra arguments' do
      allow_any_instance_of(OneviewSDK::Client).to receive(:response_handler).and_return(true)
      item = described_class.new(@client_1600, uri: '/rest/fake')
      expect(@client_1600).to receive(:rest_api).with(:delete, '/rest/fake?softDelete=false', {}, 1600)
      item.delete
    end

    it 'passes extra arguments' do
      allow_any_instance_of(OneviewSDK::Client).to receive(:response_handler).and_return(true)
      item = described_class.new(@client_1600, uri: '/rest/fake')
      expect(@client_1600).to receive(:rest_api).with(:delete, '/rest/fake?softDelete=true&force=true', {}, 1600)
      item.delete(true, true)
    end
  end
end
