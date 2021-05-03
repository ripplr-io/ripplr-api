class RemoveAuthorIdFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :author
  end
end
