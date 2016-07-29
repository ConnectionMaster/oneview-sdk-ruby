require 'spec_helper'

klass = OneviewSDK::Enclosure
RSpec.describe klass, integration: true, type: CREATE, sequence: seq(klass) do
  include_context 'integration context'

  let(:enclosure_options) do
    {
      'hostname' => $secrets['enclosure1_ip'],
      'username' => $secrets['enclosure1_user'],
      'password' => $secrets['enclosure1_password'],
      'licensingIntent' => 'OneView',
      'name' => ENCL_NAME
    }
  end

  describe '#add' do
    it 'can add an enclosure' do
      item = OneviewSDK::Enclosure.new($client, enclosure_options)
      item.set_enclosure_group(OneviewSDK::EnclosureGroup.new($client, 'name' => ENC_GROUP2_NAME))
      item.add
      expect(item['uri']).not_to be_empty
    end
  end

  describe '#environmentalConfiguration' do
    it 'Gets the script' do
      item = OneviewSDK::Enclosure.find_by($client, name: ENCL_NAME).first
      expect { item.environmental_configuration }.not_to raise_error
    end
  end

  describe '#utilization' do
    it 'Gets utilization data' do
      item = OneviewSDK::Enclosure.find_by($client, name: ENCL_NAME).first
      expect { item.utilization }.not_to raise_error
    end
  end
end
