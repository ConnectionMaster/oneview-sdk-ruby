require 'spec_helper'

klass = OneviewSDK::API500::C7000::UnmanagedDevice
RSpec.describe klass, integration: true, type: CREATE, sequence: seq(klass) do
  let(:current_client) { $client_500 }
  include_examples 'UnmanagedDeviceCreateExample', 'integration api500 context'
end
