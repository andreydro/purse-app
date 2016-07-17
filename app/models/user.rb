class User < ActiveRecord::Base
  has_many :expenses

  has_many :incomes

  has_secure_password



  def editor?
    self.role == 'editor'
  end

  def admin?
    self.role == 'admin'
  end

end
