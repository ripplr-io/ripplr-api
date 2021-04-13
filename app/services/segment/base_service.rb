module Segment
  class BaseService
    def initialize
      @analytics = Segment::Analytics.new(write_key: Rails.application.credentials[:segment_key])
    end
  end
end
