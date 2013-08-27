require 'spec_helper'
describe PerpetualPoking::Client do
  before :each do
    @client = PerpetualPoking::Client.new({base_url: 'http://example.org', api_key: 'my key', auth_token: 'let me in'})
  end
  subject { @client }
  it { should respond_to(:get) }
  it { should respond_to(:put) }
  it { should respond_to(:post) }
  it { should respond_to(:delete) }
  context 'parameterize' do
    it 'should return an empty string when no parameters are given' do
      thing = subject.send(:parameterize, {})
      thing.should eq ''
    end
    it 'should start with a ? if there are params' do
      thing = subject.send(:parameterize, {doom: 'is coming'})
      thing.should start_with '?'
    end
    it 'should not have a trailing &' do
      thing = subject.send(:parameterize, {doom: 'is coming'})
      thing.should_not end_with '&'
    end

  end

  context 'get' do
    it 'should set values correctly' do
      stub_request(:get, "https://example.org:80/things?api_key=my%20key").
        with(:headers => {'Authorization'=>'Bearer let me in'}).
        to_return(:status => 200, :body => '{"key":"value"}')
      resp = subject.get('/things')
      resp.code.should eq 200
      resp.body.should eq({'key' => 'value'})
    end
    it 'should parse get parameters' do
      stub_request(:get, "https://example.org:80/things?api_key=my%20key&thing=stuff").
        with(:headers => {'Authorization'=>'Bearer let me in'}).
        to_return(:status => 200, :body => '{"key":"value"}')
      resp = subject.get('/things', thing: :stuff)
      resp.code.should eq 200
      resp.body.should eq({'key' => 'value'})
    end
  end
end
