class AddFkToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :author_id, :integer
    add_column :likes, :post_id, :integer
    add_foreign_key :likes, :users, column: :author_id
    add_foreign_key :likes, :posts, column: :post_id
  end
end
