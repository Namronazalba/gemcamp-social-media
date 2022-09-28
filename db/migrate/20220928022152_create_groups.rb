class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.belongs_to :user
      t.string :name
      t.text :description
      t.string :banner
      t.integer :privacy
      t.timestamps
    end
  end
end
