class CreateCollaborations < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborations, id: :uuid do |t|
      t.references :repository, foreign_key: true, null: false, index: true, type: :uuid
      t.references :user, foreign_key: true, null: false, index: true, type: :uuid

      t.index [:repository_id, :user_id], unique: true
      t.timestamps
    end
  end
end
