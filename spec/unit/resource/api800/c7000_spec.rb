require 'spec_helper'

RSpec.describe OneviewSDK::API800::C7000 do
  describe '#resource_named' do
    it 'calls the OneviewSDK::API800.resource_named method' do
      expect(OneviewSDK::API800).to receive(:resource_named).with('ConnectionTemplate', 'C7000')
      described_class.resource_named('ConnectionTemplate')
    end
  end
end
