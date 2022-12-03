class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.float :rate
      t.string :name
      t.timestamps
    end
  end
end
