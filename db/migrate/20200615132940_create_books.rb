class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :rating
      t.references :lender, foreign_key: { to_table: :users }
      t.string :category
      t.text :description
      t.string :address
      t.string :cover_url

      t.timestamps
    end
  end
end
