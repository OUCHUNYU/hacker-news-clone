class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text    :content,    null: false
      t.integer :parent_id
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
