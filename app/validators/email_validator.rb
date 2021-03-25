class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value =~ Devise.email_regexp

    record.errors.add(attribute, 'is not a valid email')
  end
end
