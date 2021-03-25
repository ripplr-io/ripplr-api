module Comments
  class CopyParentPostTransformer
    def transform(record)
      record.post = record.comment.post if record.comment.present?
    end
  end
end
