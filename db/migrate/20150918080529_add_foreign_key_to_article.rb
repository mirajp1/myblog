class AddForeignKeyToArticle < ActiveRecord::Migration
  def change
	add_foreign_key :articles,:users,column: :author_id
  end
end
