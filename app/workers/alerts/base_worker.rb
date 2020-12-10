module Alerts
  class BaseWorker < ApplicationWorker
    sidekiq_options queue: :alerts
  end
end
