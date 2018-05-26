class AddPictureToFoodposts < ActiveRecord::Migration[5.2]
  def change
    add_column :foodposts, :picture, :string
  end
end
