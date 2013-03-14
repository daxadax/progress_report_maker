# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      name: "user", 
      email: "user@example.com", 
      password: "password",
      password_confirmation: "password"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
 
  # :NAME
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(name: ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a name between 3 and 20 characters" do
    long_name = "a" * 21
    short_name = "a" * 2
    
    wrong_namelength_user = User.new(@attr.merge(name: long_name) || User.new(@attr.merge(name: short_name)))
    wrong_namelength_user.should_not be_valid
  end
  
  # :EMAIL
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.should_not be_valid    
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@domain.com THE_USER_123@domain.co.uk first.last@domain.com user+filter@domain.com user-x@domain.com user@domain-name.com user@1domain.com]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      valid_email_user.should be_valid
    end      
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user_at_domain.com THE USER_123(at)domain.co.uk first.last@com user@domain. user@domain,com]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      invalid_email_user.should_not be_valid
    end      
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    User.create!(@attr.merge(:email => @attr[:email].upcase))
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  # :PASSWORDS
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
    
  end
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid      
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "wrong_password")).should_not be_valid
    end
    
    it "should require a password between 6 and 15 characters" do
      long_pass = "a" * 16
      short_pass = "a" * 5

      wrong_passlength_user = User.new(@attr.merge(password: long_pass, password_confirmation: long_pass) || User.new(@attr.merge(password: short_pass, password_confirmation: short_pass)))
      wrong_passlength_user.should_not be_valid
    end
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should write the encypted password to the database" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should exist" do
        @user.should respond_to(:has_password?)
      end
      
      it "should return 'true' if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should have a salt" do
        @user.should respond_to(:salt)
      end
      
    end
    
  end

  describe "authenticate method" do
    
    it "should exist" do
      User.should respond_to(:authenticate)
    end
    
    it "should return 'nil' on email/password mismatch" do
      User.authenticate(@attr[:email], "wrong_password").should be_nil
    end
    
    it "should return 'nil' for an email address with no user" do
      User.authenticate("user@nil.com", @attr[:password]).should be_nil
    end
    
    it "should return the user on email/password match" do
      User.authenticate(@attr[:email], @attr[:password]).should == @user
    end
    
  end

end
