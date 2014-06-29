class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :qty
      t.integer :word_id
      t.integer :article_id

      t.timestamps
    end
  end
end
