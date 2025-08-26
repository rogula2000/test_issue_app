class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :issue, null: false
      t.references :creator, null: true
      t.timestamps
    end

    add_foreign_key :comments, :issues, on_delete: :cascade
    add_foreign_key :comments, :users, column: :creator_id, on_delete: :nullify
  end
end
