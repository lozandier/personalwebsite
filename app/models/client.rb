class Client < ActiveRecord::Base
  has_attached_file :client 
  has_many :goals
end
