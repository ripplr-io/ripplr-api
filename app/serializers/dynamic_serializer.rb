module DynamicSerializer
  def self.new(records, *args)
    # From record or record_relation
    model_name = records.model_name.to_s
    klass = "#{model_name}Serializer".constantize

    klass.new(records, *args)
  end
end
