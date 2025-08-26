class CreateIssues < ActiveRecord::Migration[7.1]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.text :description
      t.references :project, null: false
      t.string :assignee_name, null: false
      t.string :status, null: false, default: "active"
      t.timestamps
    end

    add_foreign_key :issues, :projects, on_delete: :cascade
  end
end
