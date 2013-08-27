require 'spec_helper'
describe PerpetualPoking::Contact do
  subject { PerpetualPoking::Contact }
  before :each do
    PerpetualPoking.configure do |config|
      config.base_url = 'foo.com'
      config.auth_token = 'let me in'
      config.api_key = 'my key'
    end
  end
  context 'properties' do
    it { should set_property(:created_at).from(:created_date) }
    it { should set_property(:custom_fields) }
    it { should set_property(:cell_phone) }
    it { should set_property(:fax) }
    it { should set_property(:status) }
    it { should set_property(:updated_at).from(:modified_date) }
    it { should set_property(:prefix_name) }
    it { should set_property(:middle_name)}
    it { should set_property(:id)}
    it { should set_property(:first_name)}
    it { should set_property(:confirmed)}
    it { should set_property(:source)}
    it { should set_property(:company_name)}
    it { should set_property(:job_title)}
    it { should set_property(:last_name)}
    it { should set_property(:work_phone)}
    it { should set_property(:home_phone)}
    it { should set_property(:source_details)}
    it { should set_property(:addresses)}
    it { should set_property(:notes)}
    it { should set_property(:lists)}
    it { should set_property(:email_addresses)}
  end

  context 'find' do
    it { should respond_to(:find) }
    it 'should make a client call and return a Contact object' do
      id = 4
      PerpetualPoking.client.should_receive(:get).with("/contacts/#{id}").
      and_return(FakeClient.new(200, :message, {first_name: "John", last_name: "Crichton", id: id}))
      contact = PerpetualPoking::Contact.find(id)
      contact.should be_kind_of PerpetualPoking::Contact
      contact.first_name.should eq "John"
      contact.last_name.should eq "Crichton"
      contact.id.should eq id
    end

    it 'should raise an auth error if we get a 401' do
      id = 4
      PerpetualPoking.client.should_receive(:get).with("/contacts/#{id}").
      and_return(FakeClient.new(401, :message, {first_name: "John", last_name: "Crichton", id: id}))
      expect {
        PerpetualPoking::Contact.find(id)
      }.to raise_error PerpetualPoking::AuthenticationError

    end
    it 'should raise an not found error if we get a 404' do
      id = 4
      PerpetualPoking.client.should_receive(:get).with("/contacts/#{id}").
      and_return(FakeClient.new(404, :message, {first_name: "John", last_name: "Crichton", id: id}))
      expect {
        PerpetualPoking::Contact.find(id)
      }.to raise_error PerpetualPoking::NotFoundError
    end
    it 'should raise an invalid headers error if we get a 406' do
      id = 4
      PerpetualPoking.client.should_receive(:get).with("/contacts/#{id}").
      and_return(FakeClient.new(406, :message, {first_name: "John", last_name: "Crichton", id: id}))
      expect {
        PerpetualPoking::Contact.find(id)
      }.to raise_error PerpetualPoking::InvalidHeadersError
    end
    it 'should raise an server error if we get a non 200' do
      id = 4
      PerpetualPoking.client.should_receive(:get).with("/contacts/#{id}").
      and_return(FakeClient.new(500, :message, {first_name: "John", last_name: "Crichton", id: id}))
      expect {
        PerpetualPoking::Contact.find(id)
      }.to raise_error PerpetualPoking::ServerError
    end
  end
  context 'limit' do
    it { should respond_to(:limit) }
    it 'should make a client call and return a Collection of Contact objects'
  end
  context 'where' do
    it 'should have tests'
  end
  context 'save!' do
    it 'should have tests'
  end
end
