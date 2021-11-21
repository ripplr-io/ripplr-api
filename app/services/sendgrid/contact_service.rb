# NOTE: Custom Fields expect an ID instead of a name. Passing a name should be
# implemented in the future: https://github.com/sendgrid/sendgrid-ruby/issues/391
module Sendgrid
  class ContactService < BaseService
    def create_lead(email)
      contacts = [{ email: email }]

      upsert_contacts(contacts)
    end

    def sync_user(user)
      return if user.profile.bot?

      contacts = [{ email: user.email, custom_fields: {
        'e3_T': 'true' # is_user field
      }}]

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
