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

  describe "with blank name" do
    before { @user.name = " " }
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with name that is too long" do
    before { @user.name = "craig" * 11 }
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with same name as existing user" do
    before do
      new_user = User.new(name: "SAM", initials: "PTB", email: "peter@example.com", password: "foobar", password_confirmation: "foobar")
      new_user.save
    end
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with blank email" do
    before { @user.email = " " }
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with invalid email" do
    it "should not be valid" do
      addresses = %w[foo@ foo@baz,com foo@baz foo@baz]
      addresses.each do |invalid_address|
        @user.email = invalid_address       
        expect(@user).not_to be_valid
      end
    end
  end

  describe "with blank initials" do
    before { @user.initials = " " }
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with same initials as existing user" do
    before do
      new_user = User.new(name: "Peter", initials: "SH", email: "peter@example.com", password: "foobar", password_confirmation: "foobar")
      new_user.save
    end
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with no password" do
    before { @user.password = @user.password_confirmation = "" }
      
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with password that is too short" do
    before { @user.password = @user.password_confirmation = "toosh" }
      
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  describe "with password and confirmation that don't match" do
    before do
      @user.password = "foobar"
      @user.password_confirmation = "notfoobar"
    end
    it "should not be valid" do
      expect(@user).not_to be_valid
    end
  end

  

  
end
