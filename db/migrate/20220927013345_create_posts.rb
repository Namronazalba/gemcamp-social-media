class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :image
      t.string :content
      t.integer :status
      t.timestamps
    end
  end
end
