class CreateUsergroups < ActiveRecord::Migration
  def change
    create_table :usergroups do |t|
      t.references :admin, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
