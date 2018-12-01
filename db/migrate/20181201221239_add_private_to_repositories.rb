class AddPrivateToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :private, :bool, default: false
  end
end
