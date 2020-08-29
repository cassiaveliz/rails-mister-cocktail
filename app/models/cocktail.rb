class Cocktail < ApplicationRecord
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews
  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true

  before_save do
    name.downcase!
  end

  def self.search(search)
    where('name LIKE ?', "#{search}%")
  end
end
