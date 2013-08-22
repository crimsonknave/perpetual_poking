require 'spec_helper'

describe PerpetualPoking do
  it 'should return the correct version string' do
    PerpetualPoking.version_string.should == "Perpetual Poking version #{PerpetualPoking::VERSION}"
  end

  context 'conf' do
    before :each do
      @conf = PerpetualPoking.conf
    end

    it 'should return a configuration object' do
      @conf.should be_kind_of PerpetualPoking::Configuration
    end

    it 'should memoize the configuration' do
      PerpetualPoking::Configuration.should_not_receive(:new)
      PerpetualPoking.conf
    end
  end

  context 'client' do
    before :each do
      PerpetualPoking.configure do |config|
        config.base_url = 'foo.com'
        config.auth_token = 'let me in'
        config.api_key = 'my key'
      end
    end
    subject { PerpetualPoking.client }
    it { should be_kind_of PerpetualPoking::Client }
    it { should respond_to(:get) }
    it { should respond_to(:put) }
    it { should respond_to(:post) }
    it { should respond_to(:delete) }
    # it { should respond_to(:patch) } # Yes?  No?
  end

  context 'configure' do
    it 'should call set_client afterwards' do
      PerpetualPoking.conf.should_receive(:set_client).once
      PerpetualPoking.configure do |config|
        config.base_url = 'foo.com'
        config.auth_token = 'let me in'
      end
    end
  end
end
