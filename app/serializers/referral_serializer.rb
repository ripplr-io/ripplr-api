class ReferralSerializer < ActiveModel::Serializer
  attributes :name, :email, :created_at, :accepted_at
end
