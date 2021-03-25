class StripTransformer
  def transform(value)
    value.is_a?(String) ? value.strip : value
  end
end
