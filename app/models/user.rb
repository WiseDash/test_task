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

class User < ActiveRecord::Base
  attr_accessible :dateofbirth, :email, :firstname, :login, :password, :password_confirmation, :patronymic, :secondname
  has_secure_password

  before_save { |user| user.login = login.downcase }

  validates :login, presence:true, length: { minimum: 5, maximum: 32 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }
end
