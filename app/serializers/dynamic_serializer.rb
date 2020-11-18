module DynamicSerializer
  def self.new(records, *args)
    # From record or record_relation
    model_name = records.class.to_s.split('::').first
    klass = "#{model_name}Serializer".constantize

    klass.new(records, *args)
  end
end
