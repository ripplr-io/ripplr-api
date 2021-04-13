module Segment
  class BaseWorker < ApplicationWorker
    sidekiq_options queue: :metrics
  end
end
