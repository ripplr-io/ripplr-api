module Sendgrid
  module Mailer
    extend ActiveSupport::Concern

    included do
      class_attribute :_from, :_template
    end

    module ClassMethods
      def from(value)
        self._from = value
      end

      def template(value)
        self._template = value
      end
    end

    def mail
      @_mail ||= Sendgrid::MailerService.new(_template, _from)
    end
  end
end
