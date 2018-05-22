class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :book_cover
      t.string :author
      t.string :isbn
      t.float :price
      t.string :category
      t.boolean :publish_status, default: false
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
