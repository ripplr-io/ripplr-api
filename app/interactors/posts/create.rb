require 'open-uri'

module Posts
  class Create < ApplicationInteractor
    before :attach_image_from_url

    def call
      context.fail! unless context.resource.save

      Posts::GenerateInboxItemsWorker.perform_async(context.resource.id)
      Posts::BroadcastCreationWorker.perform_async(context.resource.id)
      Posts::UpdateTrendingScoreWorker.perform_async(context.resource.id)
      Mixpanel::TrackPostCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstPostWorker.perform_async(context.resource.author.id)
    end

    private

    def attach_image_from_url
      return if context.image_url.blank?
      return if context.resource.image.attached?

      uri = URI.parse(context.image_url)
      file = uri.open
      filename = File.basename(uri.path)
      context.resource.image.attach(io: file, filename: filename)
    end
  end
end
