require 'spec_helper'

RSpec.describe OneviewSDK::VolumeTemplate do
  include_context 'shared context'

  let(:fake_storage_pool) do
    {
      'name' => 'fake_storage_pool',
      'uri' => '/rest/storage-pools/fake_uri'
    }
  end

  let(:fake_storage_system) do
    {
      'name' => 'fake_storage_system',
      'uri' => '/rest/storage-systems/fake_uri'
    }
  end

  let(:fake_snapshot_pool) do
    {
      'name' => 'fake_snapshot_pool',
      'uri' => '/rest/storage-systems/snapshot-pools/fake_uri'
    }
  end


  describe '#initialize' do
    it 'sets the defaults correctly' do
      profile = OneviewSDK::VolumeTemplate.new(@client)
      expect(profile[:type]).to eq('StorageVolumeTemplateV3')
    end
  end

  describe '#create' do
    it 'adds a language header to the request' do
      item = OneviewSDK::VolumeTemplate.new(@client, name: 'Fake')
      allow_any_instance_of(OneviewSDK::Client).to receive(:rest_post).and_return(true)
      allow_any_instance_of(OneviewSDK::Client).to receive(:response_handler).and_return(uri: '/rest/fake')
      expect(@client).to receive(:rest_post).with(
        '/rest/storage-volume-templates',
        { 'Accept-Language' => 'en_US', 'body' => item.data },
        item.api_version
      )
      item.create
      expect(item['uri']).to eq('/rest/fake')
    end
  end

  describe '#delete' do
    it 'adds a language header to the request' do
      item = OneviewSDK::VolumeTemplate.new(@client, name: 'Fake', uri: '/rest/fake')
      allow_any_instance_of(OneviewSDK::Client).to receive(:rest_delete).and_return(true)
      allow_any_instance_of(OneviewSDK::Client).to receive(:response_handler).and_return(true)
      expect(@client).to receive(:rest_delete).with(
        '/rest/fake',
        { 'Accept-Language' => 'en_US' },
        item.api_version
      )
      item.delete
    end
  end

  describe '#set' do
    context 'provisioning' do
      it 'Attributes' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        volume_template.set_provisioning(true, 'Thin', '10737418240', fake_storage_pool)
        expect(volume_template['provisioning']['shareable']).to eq(true)
        expect(volume_template['provisioning']['provisionType']).to eq('Thin')
        expect(volume_template['provisioning']['capacity']).to eq('10737418240')
        expect(volume_template['provisioning']['storagePoolUri']).to eq('/rest/storage-pools/fake_uri')
      end
    end

    context 'data' do
      it 'storage system' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        volume_template.set_storage_system(fake_storage_system)
        expect(volume_template['storageSystemUri']).to eq('/rest/storage-systems/fake_uri')
      end

      it 'snapshot pool' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        volume_template.set_snapshot_pool(fake_snapshot_pool)
        expect(volume_template['snapshotPoolUri']).to eq('/rest/storage-systems/snapshot-pools/fake_uri')
      end
    end
  end

  describe '#validate' do
    context 'refreshState' do
      it 'allows valid refresh states' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        valid_states = %w(NotRefreshing RefreshFailed RefreshPending Refreshing)
        valid_states.each do |state|
          volume_template[:refreshState] = state
          expect(volume_template[:refreshState]).to eq(state)
        end
      end

      it 'does not allow invalid refresh states' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        expect { volume_template[:refreshState] = 'Complete' }.to raise_error(OneviewSDK::InvalidResource, /Invalid refresh state/)
      end
    end

    context 'status' do
      it 'allows valid statuses' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        valid_statuses = %w(OK Disabled Warning Critical Unknown)
        valid_statuses.each do |state|
          volume_template[:status] = state
          expect(volume_template[:status]).to eq(state)
        end
      end

      it 'does not allow invalid statuses' do
        volume_template = OneviewSDK::VolumeTemplate.new(@client)
        expect { volume_template[:status] = 'Complete' }.to raise_error(OneviewSDK::InvalidResource, /Invalid status/)
      end
    end
  end
end
