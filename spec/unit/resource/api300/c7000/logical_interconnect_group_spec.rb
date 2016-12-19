require 'spec_helper'

RSpec.describe OneviewSDK::API300::C7000::LogicalInterconnectGroup do
  include_context 'shared context'

  it 'inherits from API200' do
    expect(described_class).to be < OneviewSDK::API200::LogicalInterconnectGroup
  end

  describe '#initialize' do
    it 'sets the defaults correctly' do
      item = OneviewSDK::API300::C7000::LogicalInterconnectGroup.new(@client_300)
      expect(item['enclosureType']).to eq('C7000')
      expect(item['state']).to eq('Active')
      expect(item['uplinkSets']).to eq([])
      expect(item['type']).to eq('logical-interconnect-groupV300')
      path = 'spec/support/fixtures/unit/resource/lig_default_templates.json'
      expect(item['interconnectMapTemplate']).to eq(JSON.parse(File.read(path)))
      expect(item['interconnectMapTemplate']['interconnectMapEntryTemplates'].size).to eq(8)
    end
  end

  describe '#add_interconnect' do
    before :each do
      @item = OneviewSDK::API300::C7000::LogicalInterconnectGroup.new(@client_300)
      @type = 'HP VC FlexFabric-20/40 F8 Module'
    end

    it 'adds a valid interconnect' do
      expect(OneviewSDK::Interconnect).to receive(:get_type).with(@client_300, @type)
        .and_return('uri' => '/rest/fake')
      @item.add_interconnect(3, @type)
      expect(@item['interconnectMapTemplate']['interconnectMapEntryTemplates'][2]['permittedInterconnectTypeUri'])
        .to eq('/rest/fake')
    end

    it 'raises an error if the interconnect is not found' do
      expect(OneviewSDK::Interconnect).to receive(:get_type).with(@client_300, @type)
        .and_return([])
      expect(OneviewSDK::Interconnect).to receive(:get_types).and_return([{ 'name' => '1' }, { 'name' => '2' }])
      expect { @item.add_interconnect(3, @type) }.to raise_error(/not found!/)
    end
  end

  describe '#add_uplink_set' do
    it 'adds it to the \'uplinkSets\' data attribute' do
      item = OneviewSDK::API300::C7000::LogicalInterconnectGroup.new(@client_300)
      uplink = OneviewSDK::API300::C7000::UplinkSet.new(@client_300)
      item.add_uplink_set(uplink)
      expect(item['uplinkSets'].size).to eq(1)
      expect(item['uplinkSets'].first).to eq(uplink.data)
    end
  end
end
