class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :slack_id
      t.integer :role, default: 0, null: false  # instead of t.enum :role
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :slack_id, unique: true
  end
end