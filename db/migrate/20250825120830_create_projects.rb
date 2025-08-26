class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :creator
      t.timestamps
    end

    add_foreign_key :projects, :users, column: :creator_id, on_delete: :nullify
  end
end
