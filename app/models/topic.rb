class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  validates :title, length: {minimum: 2}, presence: true
  

  default_scope order('created_at DESC')
end

