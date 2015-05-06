class AddNewFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_rating, :integer
    add_column :posts, :created_timestamp, :datetime
    add_column :posts, :created_month, :string
    add_column :posts, :created_year, :integer
    add_column :posts, :created_day, :integer
    add_column :posts, :duplicateCount, :integer
    add_column :posts, :dummyStr1, :string
    add_column :posts, :dummyStr2, :string
    add_column :posts, :dummyStr3, :string
    add_column :posts, :dummyInt1, :integer
    add_column :posts, :dummyInt2, :integer
    add_column :posts, :dummyInt3, :integer
  end
end
