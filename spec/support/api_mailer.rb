module PersonalizationTestMethods
  def to
    self['to'].first['email']
  end

  def data
    self['dynamic_template_data']
  end
end

module MailerTestMethods
  def sengrid_mail
    mail.instance_variable_get(:@mail)
  end

  def from
    sengrid_mail.from['email']
  end

  def template
    sengrid_mail.template_id
  end

  def personalizations
    sengrid_mail.personalizations.map do |personalization|
      personalization.extend(PersonalizationTestMethods)
    end
  end
end

module ApiMailerHelpers
  def mailer
    @_mailer ||= described_class.new.extend(MailerTestMethods)
  end
end

RSpec.configure do |config|
  config.include ApiMailerHelpers, type: :mailer
  config.before(:each, type: :mailer) do
    stub_request(:post, /api.sendgrid.com/).to_return(status: 202)
  end
end
