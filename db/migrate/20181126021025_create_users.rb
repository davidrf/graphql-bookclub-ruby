class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.text :bio
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :picture_url
      t.string :username, null: false
      t.index :username, unique: true
    end
  end
end
