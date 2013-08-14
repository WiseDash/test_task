# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  firstname   :string(255)
#  secondname  :string(255)
#  patronymic  :string(255)
#  dateofbirth :integer
#  login       :string(255)
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(firstname: "Example Firstname", secondname: "Example Secondname", patronymic: "Example Patronymic", dateofbirth: "00.00.00", login: "ExAmPlE", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:firstname) }
  it { should respond_to(:secondname) }
  it { should respond_to(:patronymic) }
  it { should respond_to(:dateofbirth) }
  it { should respond_to(:login) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when login is too short" do
    before { @user.login = "a" * 4 }
    it {should_not be_valid }
  end

  describe "when login is too long" do
    before { @user.login = "a" * 33 }
    it {should_not be_valid }
  end

  describe "when login is already taken" do
    before do
      user_with_same_login = @user.dup
      user_with_same_login.login = @user.login.upcase
      user_with_same_login.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
end
