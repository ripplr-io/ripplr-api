module Support
  class JsonResources
    class << self
      def device_settings
        @_device_settings = load_device_settings
      end

      def subscription_settings
        @_subscription_settings = load_subscription_settings
      end

      private

      def load_device_settings
        filename = Rails.root.join('spec', 'factories', 'resources', 'device_settings.json')
        JSON.parse(File.read(filename))
      end

      def load_subscription_settings
        filename = Rails.root.join('spec', 'factories', 'resources', 'subscription_settings.json')
        JSON.parse(File.read(filename))
      end
    end
  end
end
