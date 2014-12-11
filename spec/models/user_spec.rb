require 'rails_helper'

RSpec.describe User, :type => :model do
  
  before { @user = build(:user) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "should have the right attributes" do
  	expect(@user).to respond_to(:name, :initials, :email, 
                                :admin, :password, :password_confirmation, 
                                :password_digest, :remember_token,
                                :remember_digest)
  end

  it "is valid with a name, initials, email, password, and confirmation" do
  	expect(@user).to be_valid
  end

  it "is not an admin user by default" do
    expect(@user.admin).to eq(false)
  end

  it "is not valid with blank name" do
    @user.name = " " 
    expect(@user).not_to be_valid
  end

  it "is not valid with a name that is too long" do
    @user.name = "craig" * 11
    expect(@user).not_to be_valid
  end

  it "is not valid with the same name as existing user" do
    existing_user = create(:user)
    @user.name = existing_user.name
    expect(@user).not_to be_valid
  end

  it "is not valid with blank email" do
    @user.email = " " 
    expect(@user).not_to be_valid
  end

  it "is not valid with invalid email" do
    addresses = %w[foo@ foo@baz,com foo@baz foo@baz]
    addresses.each do |invalid_address|
      @user.email = invalid_address       
      expect(@user).not_to be_valid
    end
  end

  it "is not valid with blank initials" do
    @user.initials = " " 
    expect(@user).not_to be_valid
  end

  it "is not valid with same initials as existing user" do
    existing_user = create(:user)
    @user.initials = existing_user.initials
    expect(@user).not_to be_valid
  end

  it "is not valid with no password" do
    @user.password = @user.password_confirmation = ""    
    expect(@user).not_to be_valid
  end

  it "is not valid with password that is too short" do
    @user.password = @user.password_confirmation = "toosh" 
    expect(@user).not_to be_valid
  end

  it "is not valid with password and confirmation that don't match" do
    @user.password = "foobar"
    @user.password_confirmation = "notfoobar"
    expect(@user).not_to be_valid
  end
  
end
