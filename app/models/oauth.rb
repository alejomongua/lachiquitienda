class Oauth < ActiveRecord::Base
  attr_accessible :provider, :uid

  belongs_to :usuario

  validates_presence_of :usuario
end
