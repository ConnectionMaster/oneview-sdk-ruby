# (C) Copyright 2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

module OneviewSDK
  module API200
    # Login Details resource implementation
    class LoginDetail
      BASE_URI = '/rest/logindetails'.freeze

      # Gets the login details
      # @param [OneviewSDK::client] client access for resource endpoint
      # @return [Hash] Response to the api call
      def self.get_login_details(client)
        response = client.rest_get(BASE_URI)
        client.response_handler(response)
      end
    end
  end
end
