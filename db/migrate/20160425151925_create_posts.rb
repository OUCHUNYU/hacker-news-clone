class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text    :title,  null: false
      t.text    :url
      t.text    :content
      t.integer :user_id

      t.timestamps
    end
  end
end
