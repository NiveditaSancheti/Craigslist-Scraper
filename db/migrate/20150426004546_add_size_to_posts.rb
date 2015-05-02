class AddSizeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :size, :string
  end
end
