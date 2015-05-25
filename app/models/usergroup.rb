class Usergroup < ActiveRecord::Base
  belongs_to :admin, :class_name => "User"
  has_and_belongs_to_many :notices
  has_and_belongs_to_many :users

  validates_presence_of :admin
  validates_presence_of :name
end
