class AddLikesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :likeCount, :integer
    add_column :posts, :dislikeCount, :integer
  end
end
