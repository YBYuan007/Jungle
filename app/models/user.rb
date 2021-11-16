class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  validates :password, length: {minimum: 5}
  validates :password_confirmation, length: {minimum: 5}

  before_save :downcase_fields

  def downcase_fields
     self.email = self.email.strip.downcase
  end


  def  self.authenticate_with_credentials (email, password)
    user = User.find_by_email((email.strip).downcase)
    if user && user.authenticate(password)
       user 
    else 
      nil
    end
  end 

end




