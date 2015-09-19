class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
	  t.references :commentor,references: :users,index: true
	  t.references :article,index: true,foreign_key: true

      t.timestamps null: false
    end
	add_foreign_key :comments,:users,column: :commentor_id
  end
end
