module Mixpanel
  class BaseWorker < ApplicationWorker
    sidekiq_options queue: :metrics
  end
end
