class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  before_save { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password) #this is a class method, so you don't need .new or .create to use this definition
    @logged_user = User.find_by_email(email.downcase.delete(' ')) # find the user in db
    if @logged_user && @logged_user.authenticate(password) # validate the password
      @logged_user # return the user
    else
      nil
    end
  end
end
