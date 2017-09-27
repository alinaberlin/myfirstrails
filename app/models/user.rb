
class User < ActiveRecord::Base
require "devise"
extend Devise::Models
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
has_many :orders
devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable, :validatable
end