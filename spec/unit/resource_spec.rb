require_relative './../spec_helper'

RSpec.describe OneviewSDK::Resource do
  include_context 'shared context'

  describe '#initialize' do
    it 'uses the client\'s logger' do
      res = OneviewSDK::Resource.new(@client)
      expect(res.logger).to eq(@client.logger)
    end

    it 'uses the client\'s api version' do
      res = OneviewSDK::Resource.new(@client)
      expect(res.api_version).to eq(@client.api_version)
    end

    it 'can override the client\'s api version' do
      res = OneviewSDK::Resource.new(@client, {}, 120)
      expect(res.api_version).to_not eq(@client.api_version)
      expect(res.api_version).to eq(120)
    end

    it 'starts with an empty data hash' do
      res = OneviewSDK::Resource.new(@client)
      expect(res.data).to eq({})
    end

    it 'sets the provided attributes' do
      res = OneviewSDK::Resource.new(@client, name: 'Test', description: 'None')
      expect(res[:name]).to eq('Test')
      expect(res['description']).to eq('None')
    end
  end

  describe '#like?' do
    it 'returns true for an alike hash' do
      options = { name: 'res', uri: '/rest/fake', description: 'Resource' }
      res = OneviewSDK::Resource.new(@client, options)
      expect(res.like?(description: 'Resource', uri: '/rest/fake', name: 'res')).to eq(true)
    end

    it 'returns true for an alike resource' do
      options = { name: 'res', uri: '/rest/fake', description: 'Resource' }
      res = OneviewSDK::Resource.new(@client, options)
      res2 = OneviewSDK::Resource.new(@client, options)
      expect(res.like?(res2)).to eq(true)
    end

    it 'does not compare client object or api_version' do
      options = { name: 'res', uri: '/rest/fake', description: 'Resource' }
      res = OneviewSDK::Resource.new(@client, options)
      res2 = OneviewSDK::Resource.new(@client_120, options, 120)
      expect(res.like?(res2)).to eq(true)
    end

    it 'works for nested hashes' do
      options = { name: 'res', uri: '/rest/fake', data: { 'key1' => 'val1', 'key2' => 'val2' } }
      res = OneviewSDK::Resource.new(@client, options)
      expect(res.like?(data: { key2: 'val2' })).to eq(true)
    end

    it 'returns false for unlike hashes' do
      options = { name: 'res', uri: '/rest/fake' }
      res = OneviewSDK::Resource.new(@client, options)
      expect(res.like?(data: { key2: 'val2' })).to eq(false)
    end

    it 'requires the other objet to respond to .each' do
      res = OneviewSDK::Resource.new(@client)
      expect { res.like?(nil) }.to raise_error(/Can't compare with object type: NilClass/)
    end
  end
end