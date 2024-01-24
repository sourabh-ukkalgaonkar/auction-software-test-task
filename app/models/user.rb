# frozen_string_literal: true

# User class to handle user's application.
class User < ApplicationRecord
  validates :name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  attr_accessor :password
end
