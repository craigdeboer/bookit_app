require 'rails_helper'

RSpec.describe User, :type => :model do
  
  before { @user = User.new(name: "Sam", initials: "SH", email: "shannah@motion.com", 
  	password: "foobar", password_confirmation: "foobar") }

  it "should have the right attributes" do
  	expect(@user).to respond_to(:name, :initials, :email, :admin, :password, 
  		:password_confirmation, :password_digest)
  end

  it "should be valid and not be admin" do
  	expect(@user).to be_valid
  	expect(@user.admin).to eq(false)
  end


end
