class AddTextToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :text, :string
  end
end
