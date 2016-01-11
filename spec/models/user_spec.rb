require 'rails_helper'

describe User do
  describe "Validations" do
    context "on a new user" do
      it "should not be valid without a password" do
        user = User.new(password: nil, password_confirmation: nil)
        expect(user).to_not be_valid
      end

      it "should be not be valid with a short password" do
        user = User.new(password: 'short', password_confirmation: 'short')
        expect(user).to_not be_valid
      end

      it "should not be valid with a confirmation mismatch" do
        user = User.new(password: 'short', password_confirmation: 'long')
        expect(user).to_not be_valid
      end
    end

    context "on an existing user" do
      it "should be valid with no changes" do
        user = User.create(name: "Bill", email: "Bill@fake.com", password: 'password1', password_confirmation: 'password1')
        expect(user).to be_valid
      end

      it "should not be valid with an empty password" do
        user = User.create(name: "Bill", email: "Bill@fake.com", password: 'password1', password_confirmation: 'password1')
        user.password = user.password_confirmation = ""
        expect(user).to_not be_valid
      end

      it "should be valid with a new (valid) password" do
        user = User.create(name: "Bill", email: "Bill@fake.com", password: 'password1', password_confirmation: 'password1')
        user.password = user.password_confirmation = "new password"
        expect(user).to be_valid
      end
    end
  end
end
