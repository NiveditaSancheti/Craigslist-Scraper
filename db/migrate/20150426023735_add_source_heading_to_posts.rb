class AddSourceHeadingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :source_heading, :string
  end
end
