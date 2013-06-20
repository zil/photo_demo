class Photo < ActiveRecord::Base
  attr_accessible :descrption, :name
  validates :name, :presence => true
  validates :path, :presence => true

end
