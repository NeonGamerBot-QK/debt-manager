class CreateDebts < ActiveRecord::Migration[8.1]
  def change
    create_table :debts do |t|
      t.integer :amount, null: false
      t.integer :status, default: 0, null: false
      t.references :owed, null: false, foreign_key: { to_table: :users }
      t.references :owing, null: false, foreign_key: { to_table: :users }
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end