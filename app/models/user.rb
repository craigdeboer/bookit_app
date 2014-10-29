class User < ActiveRecord::Base
	attr_accessor :remember_token

	has_many :bookings
	has_many :wheelchairs, through: :bookings

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :initials, presence: true, uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,		 presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
	validates :password, presence: true, length: { minimum: 6, maximum: 255 }
	validates :password_confirmation, presence: true

	has_secure_password

	# Returns a hashed digest of the given string
	def User.digest(string)
		BCrypt::Password.create(string)
		# cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random url safe token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(self.remember_token))
	end

	# Returns true if the given remember token matches the digest.
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user (sets remember_digest to nil) when a user logs out.
	def forget
		update_attribute(:remember_digest, nil)
	end

end
