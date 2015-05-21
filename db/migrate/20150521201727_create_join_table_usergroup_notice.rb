class CreateJoinTableUsergroupNotice < ActiveRecord::Migration
  def change
    create_join_table :usergroups, :notices do |t|
      # t.index [:usergroup_id, :notice_id]
      # t.index [:notice_id, :usergroup_id]
    end
  end
end
