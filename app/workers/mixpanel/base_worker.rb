module Mixpanel
  class BaseWorker < ApplicationWorker
    include Sidekiq::Worker

    sidekiq_options queue: :metrics
  end
end
