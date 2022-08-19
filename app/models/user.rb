require 'uri'

class User < ApplicationRecord
  has_secure_password
  
  :firstname
  :lastname
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
