module Sendgrid
  class MailerService < BaseService
    def initialize(template, from)
      @mail = build_mail(template, from)
      super()
    end

    def add_personalization(to: nil, data: nil)
      raise 'To can\'t be blank' if to.blank?

      personalization = SendGrid::Personalization.new
      personalization.add_to(SendGrid::Email.new(email: to))
      personalization.add_dynamic_template_data(data.stringify_keys) if data.present?

      @mail.add_personalization personalization
    end

    def add_attachment(name: nil, file: nil)
      raise 'Name can\'t be blank' if name.blank?
      raise 'File can\'t be blank' if file.blank?

      attachment = SendGrid::Attachment.new
      attachment.filename = name
      attachment.content = file

      @mail.add_attachment attachment
    end

    def reply_to=(email)
      @mail.reply_to = SendGrid::Email.new(email: email)
    end

    def deliver
      raise 'Personalizations can\'t be blank' if @mail.personalizations.blank?

      @sg = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid_token])
      response = @sg.client.mail._('send').post(request_body: @mail.to_json)

      Raven.capture_message(response.body) unless response.status_code == :ok
    end

    private

    def build_mail(template, from)
      raise 'Template can\'t be blank' if template.blank?
      raise 'From can\'t be blank' if from.blank?

      mail = SendGrid::Mail.new
      mail.mail_settings = mail_settings

      mail.template_id = template
      mail.from = SendGrid::Email.new(email: from)

      mail
    end

    def mail_settings
      settings = SendGrid::MailSettings.new
      settings.sandbox_mode = SendGrid::SandBoxMode.new(enable: !Rails.env.production?)
      settings
    end
  end
end
