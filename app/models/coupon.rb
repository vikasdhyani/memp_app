class Coupon < ActiveRecord::Base
  has_and_belongs_to_many :plans
  has_and_belongs_to_many :branches

  validates :name, :presence => true
  validates :amount, :presence => true
  validates :discount, :presence => true
  validates :start_date, :presence => true
  validates :expiry_date, :presence => true
  validate  :expiry_date_validation
  validate  :start_date_validation
  validates_numericality_of :amount, :discount

  def expiry_date_validation
   if expiry_date < start_date
    errors.add(:expiry_date, "can't be before start date!")
   end
  end

  def start_date_validation
   if start_date < Date.current-1
    errors.add(:start_date, "can't be backdated!")
   end
  end
end
