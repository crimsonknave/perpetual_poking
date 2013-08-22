require 'spec_helper'
describe PerpetualPoking::Configuration do
  context 'set_client' do
    it 'should raise an error if base_url is not provided' do
      c = PerpetualPoking::Configuration.new
      c.api_key = 'foo'
      c.auth_token = 'bar'
      expect {
        c.set_client
      }.to raise_error PerpetualPoking::ConfigurationError
    end
    it 'should raise an error if api_key is not provided' do
      c = PerpetualPoking::Configuration.new
      c.base_url = 'foo'
      c.auth_token = 'bar'
      expect {
        c.set_client
      }.to raise_error PerpetualPoking::ConfigurationError
    end
    it 'should raise an error if auth_token is not provided' do
      c = PerpetualPoking::Configuration.new
      c.api_key = 'foo'
      c.base_url = 'bar'
      expect {
        c.set_client
      }.to raise_error PerpetualPoking::ConfigurationError
    end
    it 'should assign_to @client' do
      c = PerpetualPoking::Configuration.new
      c.api_key = 'foo'
      c.auth_token = 'bar'
      c.base_url = 'bar'
      c.set_client
      c.client.should be_kind_of PerpetualPoking::Client
    end
  end
end
