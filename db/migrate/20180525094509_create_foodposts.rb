class CreateFoodposts < ActiveRecord::Migration[5.2]
  def change
    create_table :foodposts do |t|
      t.text :content
      t.integer :protein
      t.integer :fat
      t.integer :carbohydrate
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :foodposts, [:user_id, :created_at]
  end
end
