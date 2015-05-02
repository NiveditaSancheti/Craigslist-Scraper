class AddVinToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :vin_no, :string
  end
end
