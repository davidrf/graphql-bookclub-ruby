class CreateRepository < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories, id: :uuid do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: false, index: true, type: :uuid
      t.index [:name, :user_id], unique: true
      t.timestamps
    end
  end
end
