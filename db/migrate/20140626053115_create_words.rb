class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :ord

      t.timestamps
    end
  end
end
