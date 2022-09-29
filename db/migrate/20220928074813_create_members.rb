class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :user
      t.belongs_to :member
      t.belongs_to :group
      t.string :status
      t.integer :role
      t.timestamps
    end
  end
end
