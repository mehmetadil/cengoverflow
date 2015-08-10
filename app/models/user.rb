class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :answers , dependent: :destroy
  has_many :questions , dependent: :destroy
  has_one :profile , dependent: :destroy
  has_and_belongs_to_many :roles
  after_create :make_profile , on: :create 
  before_create :set_default_role
  def set_default_role
    self.roles << Role.last
  end
  
  def make_profile
    create_profile(
      first_name: "İsimsiz Kullanıcı",
      last_name: "",
      phone: ""
    )
  end
end
