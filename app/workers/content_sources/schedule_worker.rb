module ContentSources
  class ScheduleWorker < ApplicationWorker
    def perform
      ContentSource.all.each do |cs|
        ContentSources::UpdateWorker.perform_async(cs.id)
      end
    end
  end
end
