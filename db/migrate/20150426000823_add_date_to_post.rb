class AddDateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :created_on, :string
  end
end
