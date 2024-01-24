# frozen_string_literal: true

# User class to handle user's application.
class User < ApplicationRecord
  validates :name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  has_many :projects

  attr_accessor :password

  before_save :set_secure_password

  def authenticate?(password_string)
    generate_secure_password(password_string) == secure_password
  end

  private

  def set_secure_password
    generate_unique_salt if salt.blank?
    self.secure_password = generate_secure_password(password)
  end
  
  def generate_secure_password(password_string)
    Digest::MD5.hexdigest(
      Digest::MD5.hexdigest(
        "#{password_string}.#{salt}"
      )
    )
  end

  def generate_unique_salt
    loop do
      self.salt = generate_random_string
      break unless User.exists?(salt: salt)
    end
  end

  def generate_random_string
    SecureRandom.hex(16)  # Adjust the length as needed
  end
end
