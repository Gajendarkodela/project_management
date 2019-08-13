class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :description
      t.string :status, default: 'New'
      t.integer :project_id
      t.integer :developer_id
      t.timestamps
    end
  end
end
