require 'active_record'
require 'transforms/transformers/strip_transformer'
require 'transforms/transformers/downcase_transformer'

module Transforms
  module Concerns
    def self.included(base)
      base.instance_eval do
        extend ClassMethods
        include InstanceMethods
        before_validation :apply_transformers

        class << self
          attr_accessor :transformers
        end
      end
    end
  end

  module ClassMethods
    def transforms(attribute, transformers)
      prepend Module.new {
        define_method :"#{attribute}=" do |value|
          transformers.each do |name, _options|
            klass = "#{name.to_s.camelize}Transformer".constantize
            value = klass.new.transform(value)
          end
          super(value)
        end
      }
    end

    def transforms_with(klass)
      self.transformers ||= []
      self.transformers << klass
    end
  end

  module InstanceMethods
    private

    def apply_transformers
      return unless self.class.transformers

      self.class.transformers.each do |klass|
        klass.new.transform(self)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.include Transforms::Concerns
end
