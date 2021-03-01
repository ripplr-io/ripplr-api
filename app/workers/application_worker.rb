class ApplicationWorker
  include Sidekiq::Worker

  def log_info(message)
    Rails.logger.info "[#{self.class.name}] -> #{message}"
  end

  def log_resource_interaction(interactor)
    error_messages = interactor.resource.errors.full_messages
    message = interactor.success? ? 'success' : "failed: #{error_messages}"
    log_info(message)
  end
end
