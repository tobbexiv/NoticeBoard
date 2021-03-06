class Notice < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :category
  has_and_belongs_to_many :usergroups

  validates_presence_of :creator
  validates_presence_of :title
  validates_presence_of :category_id
  validates_presence_of :text

  scope :own, lambda { |user|
                           where("creator_id = ?", user.id)
                         }

  scope :accessgranted, lambda { |user|
                                    joins(:usergroups => :users).where("user_id = ?", user.id)
                                  }
end
