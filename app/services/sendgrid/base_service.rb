module Sendgrid
  class BaseService
    LEAD_LIST_ID = '78c7009a-78f2-46ac-95d0-a5b8d2578c33'.freeze
    USER_LIST_ID = 'ba37a48b-4ff2-40da-9027-600a530676ec'.freeze

    def initialize
      @sg = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid_token])
    end

    def create_lead(email)
      contacts = [{ email: email }]
      list_ids = [LEAD_LIST_ID]

      upsert_contacts(contacts, list_ids)
    end

    def sync_user(user)
      contacts = [{ email: user.email }]
      list_ids = [USER_LIST_ID]

      upsert_contacts(contacts, list_ids)
      update_subscription(user.email, user.subscribed_to_marketing)
    end

    private

    def upsert_contacts(contacts, list_ids)
      @sg.client.marketing.contacts.put(request_body: {
        contacts: contacts,
        list_ids: list_ids
      })
    end

    def update_subscription(email, should_subscribe)
      should_subscribe ? subscribe(email) : unsubscribe(email)
    end

    def unsubscribe(email)
      @sg.client.asm.suppressions.global._(email).delete
    end

    def subscribe(email)
      @sg.client.asm.suppressions.global.post(request_body: {
        recipient_emails: [email]
      })
    end
  end
end
