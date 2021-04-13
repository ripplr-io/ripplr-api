module Posts
  class Create < ApplicationInteractor
    before :attach_image_from_url

    def call
      context.fail! unless context.resource.save

      Posts::GenerateInboxItemsWorker.perform_async(context.resource.id)
      Posts::BroadcastCreationWorker.perform_async(context.resource.id)
      Posts::UpdateTrendingScoreWorker.perform_async(context.resource.id)
      Segment::TrackPostCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstPostWorker.perform_async(context.resource.author.id)
    end

    private

    def attach_image_from_url
      return if context.resource.image_url.blank?
      return if context.resource.image.attached?

      image_data = Attachments::FetchImageService.new(context.resource.image_url).call
      context.resource.image.attach(image_data)
    end
  end
end
