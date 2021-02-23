module Sendgrid
  class ContactService < BaseService
    def create_lead(email)
      contacts = [{ email: email }]

      upsert_contacts(contacts)
    end

    def sync_user(user)
      contacts = [{ email: user.email, custom_fields: { is_user: 'true' }}]

      upsert_contacts(contacts)
    end

    private

    def upsert_contacts(contacts)
      @sg.client.marketing.contacts.put(request_body: {
        contacts: contacts
      })
    end
  end
end
