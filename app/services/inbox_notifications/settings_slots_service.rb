module InboxNotifications
  class SettingsSlotsService
    def initialize(slots)
      @slots = slots
    end

    def next_available_slot
      hours_of_day = slots_to_hours_of_day
      return nil if hours_of_day.empty?

      # Slots today
      hours_of_day.each do |hour|
        time = Time.current.beginning_of_day + hour
        return time if time >= Time.current.beginning_of_hour
      end

      # First slot tomorrow
      Time.current.beginning_of_day + 1.day + hours_of_day.first
    end

    private

    # Slots are originally in the format '10:00'
    def slots_to_hours_of_day
      @slots.map do |h|
        next unless hour_in_correct_format(h.to_s)

        h.split(':').first.to_i.hours
      end.compact.uniq.sort
    end

    def hour_in_correct_format(hour)
      hour.match?(/^(0[0-9]|1[0-9]|2[0-3]):00$/)
    end
  end
end
