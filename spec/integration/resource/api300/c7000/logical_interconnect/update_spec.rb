require 'spec_helper'

RSpec.describe OneviewSDK::API300::C7000::LogicalInterconnect, integration: true, type: UPDATE do
  let(:current_client) { $client_300 }
  let(:enclosure_class) { OneviewSDK::API300::C7000::Enclosure }
  let(:ethernet_class) { OneviewSDK::API300::C7000::EthernetNetwork }
  let(:interconnect_class) { OneviewSDK::API300::C7000::Interconnect }
  let(:log_int_name) { LOG_INT_NAME }
  let(:encl_name) { ENCL_NAME }

  it_behaves_like 'LogicalInterconnectUpdateExample', 'integration api300 context'

  it_behaves_like 'ScopeHelperMethodsExample', OneviewSDK::API300::C7000::Scope do
    let(:item) { described_class.get_all(current_client).first }
  end

  # should create the uplinkSet again, because the compliance method removed it, but it one is used in uplinkSet update tests
  it_behaves_like 'UplinkSetCreateExample', 'integration context' do
    let(:li_name) { LOG_INT_NAME }
    let(:described_class) { OneviewSDK::API300::C7000::UplinkSet }
  end
end
