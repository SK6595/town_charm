class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
