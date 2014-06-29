class RemoveTextFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :text, :string
  end
end
