class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true

  def admin?
  	self.type == 'Admin' 
  end

  def developer?
  	self.type == 'Developer' 
  end
end
