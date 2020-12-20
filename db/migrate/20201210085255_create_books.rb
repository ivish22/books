class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :content
      t.references :user, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
