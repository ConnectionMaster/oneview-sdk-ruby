require_relative '_client'

# Example: Create Volumes from the creation mehtods
# NOTE: This will use a few volume systems and create 6 volumes, one for each creation type
# NOTE: You'll need to add the following instance variable to the _client.rb file with valid values for your environment:
#   @storage_system_ip
#   @unmanaged_volume_wwn (optional)

fail 'Must set @storage_system_ip in _client.rb' unless @storage_system_ip


# 1) Common = Storage System + Storage Pool
puts '1) Common = Storage System + Storage Pool'

options1 = {
  name: 'ONEVIEW_SDK_TEST_VOLUME_1',
  description: 'Test volume with common creation: Storage System + Storage Pool',
  provisionType: 'Full',
  shareable: true
}

volume1 = OneviewSDK::Volume.new(@client, options1)
volume1.set_requested_capacity(512 * 1024 * 1024) # 512MB

# Set Storage System
storage_system = OneviewSDK::StorageSystem.new(@client, credentials: { ip_hostname: @storage_system_ip })
storage_system.retrieve!
volume1.set_storage_system(storage_system)


# Retrieve a Storage Pool
pools = OneviewSDK::StoragePool.find_by(@client, storageSystemUri: storage_system[:uri])
fail 'ERROR: No storage pools found attached to the provided storage system' if pools.empty?
storage_pool = pools.first
volume1.set_storage_pool(storage_pool)

volume1.create!
puts "  Created #{volume1['name']}"


# 2) Template = Storage Volume Template
# CANNOT IMPLEMENT: Missing StorageVolumeTemplate resource
puts '2) Template = Storage Volume Template'
puts '  TODO: StorageVolumeTemplate resource not implemented'


# 3) Common with snapshots = Storage System + Storage Pool + Snapshot Pool
puts '3) Common with snapshots = Storage System + Storage Pool + Snapshot Pool'

options3 = {
  name: 'ONEVIEW_SDK_TEST_VOLUME_3',
  description: 'Test volume - common creation with snapshot pool: Storage System + Storage Pool + Snapshot Pool',
  provisionType: 'Thin',
  shareable: false
}

volume3 = OneviewSDK::Volume.new(@client, options3)

volume3.set_storage_system(storage_system)
volume3.set_storage_pool(storage_pool)
volume3.set_requested_capacity(1024 * 1024 * 1024) # 1GB
volume3.set_snapshot_pool(storage_pool) # The same snapshot pool of the storage pool

volume3.create!
puts "  Created #{volume3['name']}"

# Create volume snapshot:
volume3.create_snapshot(type: 'Snapshot', name: '{volumeName}_{timestamp}', description: 'New snapshot')

if @unmanaged_volume_wwn
  # 4) Management = Storage System + wwn
  puts '4) Management = Storage System + wwn'

  options4 = {
    name: 'ONEVIEW_SDK_TEST_VOLUME_4',
    description: 'Test volume - management creation: Storage System + wwn',
    wwn: @unmanaged_volume_wwn, # Need unmanaged volume
    shareable: false
  }

  volume4 = OneviewSDK::Volume.new(@client, options4)
  volume4.set_storage_system(storage_system)

  volume4.create!
  puts "Created #{volume4['name']}"
end


puts 'Cleaning up...'
volume1.delete
# volume2.delete
volume3.snapshots.first.delete
volume3.delete
volume4.delete if @unmanaged_volume_wwn
puts 'Clean up complete!'