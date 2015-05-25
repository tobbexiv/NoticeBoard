class CreateJoinTableUserUsergroup < ActiveRecord::Migration
  def change
    create_join_table :users, :usergroups do |t|
      # t.index [:user_id, :usergroup_id]
      # t.index [:usergroup_id, :user_id]
    end
  end
end
