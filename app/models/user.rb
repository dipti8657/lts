class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :totalleaves
  before_save :default_value_for_role
  after_create :default_value_for_joining_date
  has_many :leaves, :dependent => :destroy
# validates_associated :leaves
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^[-a-z0-9_+\.]+\@(cuberoot\.in)$/i, :message => "should be a cuberoot.in email" }


   # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :manager_id, :joining_date, :role

  def totalleaves
    @setup = Setup.find(:all, :conditions =>['year = ?', "#{Time.now.year}"])
    @setup.each do |s|
      leave_per_month = (s.total_leaves.to_f/12.to_f).to_f
      month_by_no = self.joining_date.strftime("%m")
      leave_per_employee = (( 12 - (month_by_no.to_i - 1 ).to_f) * (leave_per_month.to_f )).to_f
      self.total_leaves = leave_per_employee.to_f
    end
  end

  def default_value_for_role
    self.role = "employee"
  end

  def default_value_for_joining_date
    self.joining_date = "2012-01-01"
  end

end



