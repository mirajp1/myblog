class User < ActiveRecord::Base
	attr_accessor :password
	validates_presence_of :password
	validates_length_of :password,minimum: 6
	validates_confirmation_of :password
	before_save :encrypt_password	
	validates :name, presence:true,length:{maximum: 50}
	validates :email,presence:true,length:{maximum: 255}, format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness:true
	
	def encrypt_password
		self.password_salt=BCrypt::Engine.generate_salt
		self.password_hash=BCrypt::Engine.hash_secret(password,password_salt)
	end

	def self.authenticate(email,password)
		user=User.find_by(email: email)

		if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
			user		
		else
			nil
		end
	end
	

end
