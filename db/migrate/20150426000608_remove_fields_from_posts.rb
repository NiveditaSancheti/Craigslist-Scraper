class RemoveFieldsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :created_on, :date
  end
end
