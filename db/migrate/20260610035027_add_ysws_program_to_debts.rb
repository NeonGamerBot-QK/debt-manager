class AddYswsProgramToDebts < ActiveRecord::Migration[8.1]
  def change
    add_column :debts, :ysws_program, :string
    change_column_null :debts, :owed_id, true
  end
end
