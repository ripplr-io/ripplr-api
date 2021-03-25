class DowncaseTransformer
  def transform(value)
    value.is_a?(String) ? value.downcase : value
  end
end
