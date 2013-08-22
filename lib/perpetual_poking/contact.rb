module PerpetualPoking
  class Contact < Cot::Frame
    property :created_at, :from => :created_date
    property :custom_fields
    property :cell_phone
    property :fax
    property :status
    property :updated_at, :from => :modified_date
    property :prefix_name
    property :middle_name
    property :id
    property :first_name
    property :confirmed
    property :source
    property :company_name
    property :job_title
    property :last_name
    property :work_phone
    property :home_phone
    property :source_details
    property :addresses
    property :notes
    property :lists
    property :email_addresses

    def self.get(id)
      resp = PerpetualPoking.client.get "/contacts/#{id}"
      raise PerpetualPoking::AuthenticationError.new resp.body if resp.code == 401
      raise PerpetualPoking::NotFoundError.new resp.message if resp.code == 404
      # This *should* never come up since we should be setting them correctly
      raise PerpetualPoking::InvalidHeadersError.new resp.message if resp.code == 406
      raise PerpetualPoking::ServerError.new resp.message if resp.code != 200
      Contact.new resp.body
    end
  end
end
