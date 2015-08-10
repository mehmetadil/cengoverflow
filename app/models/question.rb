class Question < ActiveRecord::Base
  validates :title, :content, presence: true #Boş geçilmesin
  validates :title, length: {maximum: 50}
  has_many :answers , dependent: :destroy
  belongs_to :user
  is_impressionable
  has_and_belongs_to_many :tags
end
