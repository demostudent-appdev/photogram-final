class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.boolean :is_private
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :comments_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
