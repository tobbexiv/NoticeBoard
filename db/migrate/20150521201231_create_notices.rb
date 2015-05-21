class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :creator, index: true, foreign_key: true
      t.string :title
      t.references :category, index: true, foreign_key: true
      t.text :text

      t.timestamps null: false
    end
  end
end
