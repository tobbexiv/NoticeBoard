class Notice < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :category
  has_and_belongs_to_many :usergroups
end
