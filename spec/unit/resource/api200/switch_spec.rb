require 'spec_helper'

RSpec.describe OneviewSDK::Switch do
  include_context 'shared context'

  describe '#retrieve!' do
    before :each do
      resp = FakeResponse.new(members: [
        { name: 'name1', uri: 'uri1', serialNumber: 'sn1' },
        { name: 'name2', uri: 'uri2', serialNumber: 'sn2' }
      ])
      allow(@client_200).to receive(:rest_get).with(described_class::BASE_URI, {}).and_return(resp)
    end

    it 'retrieves by name' do
      expect(described_class.new(@client_200, name: 'name1').retrieve!).to be true
      expect(described_class.new(@client_200, name: 'fake').retrieve!).to be false
    end

    it 'retrieves by uri' do
      expect(described_class.new(@client_200, uri: 'uri1').retrieve!).to be true
      expect(described_class.new(@client_200, uri: 'fake').retrieve!).to be false
    end

    it 'retrieves by serialNumber' do
      expect(described_class.new(@client_200, serialNumber: 'sn1').retrieve!).to be true
      expect(described_class.new(@client_200, serialNumber: 'fake').retrieve!).to be false
    end
  end

  describe '#exists?' do
    before :each do
      resp = FakeResponse.new(members: [
        { name: 'name1', uri: 'uri1', serialNumber: 'sn1' },
        { name: 'name2', uri: 'uri2', serialNumber: 'sn2' }
      ])
      allow(@client_200).to receive(:rest_get).with(described_class::BASE_URI, {}).and_return(resp)
    end

    it 'finds it by name' do
      expect(described_class.new(@client_200, name: 'name1').exists?).to be true
      expect(described_class.new(@client_200, name: 'fake').exists?).to be false
    end

    it 'finds it by uri' do
      expect(described_class.new(@client_200, uri: 'uri1').exists?).to be true
      expect(described_class.new(@client_200, uri: 'fake').exists?).to be false
    end

    it 'finds it by serialNumber' do
      expect(described_class.new(@client_200, serialNumber: 'sn1').exists?).to be true
      expect(described_class.new(@client_200, serialNumber: 'fake').exists?).to be false
    end
  end

  describe '#remove' do
    it 'Should support remove' do
      switch = OneviewSDK::Switch.new(@client_200, uri: '/rest/switches/100')
      expect(@client_200).to receive(:rest_delete).with('/rest/switches/100', {}, 200).and_return(FakeResponse.new({}))
      switch.remove
    end
  end

  describe '#get_type' do
    it 'finds the specified switch' do
      switch_type_list = FakeResponse.new(
        'members' => [
          { 'name' => 'SwitchA', 'uri' => 'rest/fake/A' },
          { 'name' => 'TheSwitch', 'uri' => 'rest/fake/switch' },
          { 'name' => 'SwitchC', 'uri' => 'rest/fake/C' }
        ]
      )
      expect(@client_200).to receive(:rest_get).with('/rest/switch-types').and_return(switch_type_list)
      @item = OneviewSDK::Switch.get_type(@client_200, 'TheSwitch')
      expect(@item['uri']).to eq('rest/fake/switch')
    end
  end

  describe 'statistics' do
    before :each do
      @item = OneviewSDK::Switch.new(@client_200, {})
    end

    it 'switch' do
      expect(@client_200).to receive(:rest_get).with('/statistics/').and_return(FakeResponse.new)
      @item.statistics
    end

    it 'port' do
      expect(@client_200).to receive(:rest_get).with('/statistics/p1').and_return(FakeResponse.new)
      @item.statistics('p1')
    end
  end

  describe 'undefined methods' do
    it 'does not allow the create action' do
      switch = OneviewSDK::Switch.new(@client_200)
      expect { switch.create }.to raise_error(OneviewSDK::MethodUnavailable, /The method #create is unavailable for this resource/)
    end

    it 'does not allow the update action' do
      switch = OneviewSDK::Switch.new(@client_200)
      expect { switch.update }.to raise_error(OneviewSDK::MethodUnavailable, /The method #update is unavailable for this resource/)
    end

    it 'does not allow the refresh action' do
      switch = OneviewSDK::Switch.new(@client_200)
      expect { switch.refresh }.to raise_error(OneviewSDK::MethodUnavailable, /The method #refresh is unavailable for this resource/)
    end

    it 'does not allow the delete action' do
      switch = OneviewSDK::Switch.new(@client_200)
      expect { switch.delete }.to raise_error(OneviewSDK::MethodUnavailable, /The method #delete is unavailable for this resource/)
    end
  end
end
