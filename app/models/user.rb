class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :leaves, :dependent => :destroy
  validates_associated :leaves
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^[-a-z0-9_+\.]+\@(cuberoot\.in)$/i, :message => "should be a cuberoot.in email" }


   # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :manager_id
end
