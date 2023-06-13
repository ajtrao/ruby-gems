class Service < ApplicationRecord
  validates :name , presence: true, uniqueness: { case_sensitive: false}
  validates :duration, numericality: { greater_than_or_equal_to: 0, less_than: 180 }, presence: true, uniqueness: { case_sensitive: false }
  validates :client_price, numericality: { greater_than_or_equal_to: 0, less_than: 10000 }, presence: true
  def to_s
    name
  end
end
