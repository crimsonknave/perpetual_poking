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

    def self.find(id)
      resp = PerpetualPoking.client.get "/contacts/#{id}"
      Contact.new resp.body
    end

    def self.limit(num)
      PerpetualPoking::Collection.new(self).limit(num)
    end
    def self.where(args)
      PerpetualPoking::Collection.new(self).where(args)
    end

    def self.search(params)
      resp = PerpetualPoking.client.get('/contacts', params)
      resp.body
    end

    def save!
      if exists? and !changed?
        puts "No changes to the contact, no rest call required" #turn this into a log
        return true
      end
      if exists?
        resp = PerpetualPoking.client.put("/contacts/#{id}", serializable_hash)
      else
        resp = PerpetualPoking.client.post("/contacts", serializable_hash)
      end
      #Added these to cot,but not pushed
      @previously_changed = changes
      @changed_attributes.clear
    end
  end
end
