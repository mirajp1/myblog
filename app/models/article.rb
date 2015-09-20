class Article < ActiveRecord::Base
	belongs_to :author,:foreign_key => "author_id",:class_name => :User,inverse_of: :articles
	has_many :comments,inverse_of: :article,dependent: :destroy
	validates :author,presence: true
	validates :body,presence: true
	validates :title,presence: true,length: {minimum: 5}

	
end
