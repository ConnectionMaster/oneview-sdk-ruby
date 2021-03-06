require 'spec_helper'

RSpec.describe OneviewSDK::API1200::C7000::Interconnect do
  include_context 'shared context'

  it 'inherits from OneviewSDK::API1000::C7000::Interconnect' do
    expect(described_class).to be < OneviewSDK::API1000::C7000::Interconnect
  end

  describe '#initialize' do
    it 'should be initialize the instance with default values' do
      item = described_class.new(@client_1200)
      expect(item['type']).to eq('InterconnectV6')
    end
  end
end
