class User < ActiveRecord::Base

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :initials, presence: true, uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,		 presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
	validates :password, presence: true, length: { minimum: 6, maximum: 255 }
	validates :password_confirmation, presence: true

	has_secure_password
end
