class Comment < ActiveRecord::Base

	belongs_to :commentor,:foreign_key => "commentor_id",:class_name => :User,inverse_of: :comments
	belongs_to :article,inverse_of: :comments
	validates :commentor,presence: true
	validates :body,presence: true
	validates :article,presence: true

end
