require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should register the user when all the fields are present" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir@example.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user).to be_valid
    end

    it "should not be valid when the name is missing" do
      @user = User.new(
        email: "amir@example.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should not be valid when the email is missing" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should not be valid when the password is missing" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir@example.com",
        password_confirmation: "123456"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not be valid when the password_confirmation is missing" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir@example.com",
        password: "123456"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should not be valid when the email is not unique" do
      @user1 = User.new(
        name: "Amir Ghandeharioon",
        email: "amir@example.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user1.save
      @user2 = User.new(
        name: "Riley Gowan",
        email: "amir@example.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should not be valid when the password length is less than 6 characters" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir@example.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    it "should login when the user credentials are correct" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir.ghandeharioon@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user.save!
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to be_truthy
    end

    it "should login regardless of whitespaces in email" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir.ghandeharioon@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user.save!
      user = User.authenticate_with_credentials("amir .ghandeharioon@gmail.com", @user.password)
      expect(user).to be_truthy
    end

    it "should login regardless of case sensitivity in email" do
      @user = User.new(
        name: "Amir Ghandeharioon",
        email: "amir.ghandeharioon@GMAIL.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user.save!
      user = User.authenticate_with_credentials("AMIR.ghandeharioon@gmail.com", @user.password)
      expect(user).to be_truthy
    end
  end
end
