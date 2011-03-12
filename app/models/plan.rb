class Plan < ActiveRecord::Base
  has_and_belongs_to_many :coupons
  has_and_belongs_to_many :branches
  
  attr_accessible :name, :start_date, :expiry_date, :security_deposit, :registration_fee,
    :reading_fee, :magazine_fee, :num_books, :num_magazines, :book_return_days,
    :mandatory_months, :subscription, :frequency, :category, :home_delivery,
    :reading_limit, :limit_basis, :restricted_to_branch, :allow_renewal, :branch_ids, :coupon_ids

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 50 }
  validates :security_deposit, :presence => true, :numericality => {:greater_than => -1 }
  validates :registration_fee, :presence => true, :numericality => {:greater_than => -1 }
  validates :reading_fee, :presence => true, :numericality => {:greater_than => -1 }
  validates :magazine_fee, :presence => true, :numericality => {:greater_than => -1 }
  validates :num_books, :presence => true, :numericality => {:greater_than => -1 }
  validates :num_magazines, :presence => true, :numericality => {:greater_than => -1 }
  validates :book_return_days, :presence => true, :numericality => {:greater_than => -1 }
  validates :mandatory_months, :presence => true, :numericality => {:greater_than => -1 }
  
  after_create { generateNewPlanEvent('NEW_PLAN_CREATION') }
  after_update { generateNewPlanEvent('NEW_PLAN_UPDATION') }
  before_destroy { generateNewPlanEvent('NEW_PLAN_DELETION') }
  before_save :set_defaults

  def monthly_amount
    reading_fee + magazine_fee
  end
  
  def reading_fee_for_term(signUpMonths)
    if subscription && frequency =="M"
      freeMonths = signUpMonths/6
      monthly_amount * (signUpMonths - freeMonths)
    elsif subscription && frequency =="Y"
      monthly_amount
    else
      0.0
    end
  end

  def total_due_for_term(signUpMonths, coupon_id)
    if !coupon_id.nil? && coupon_id > 0
      coupon = self.coupons.find(coupon_id)
      rebate = coupon.discount + coupon.amount
    else  
      rebate = 0
    end
    security_deposit + registration_fee + reading_fee_for_term(signUpMonths) - rebate
  end
  
  def pay_months_for_term(signUpMonths)
    signUpMonths - signUpMonths/6
  end

  def decodefrequency(freq)
   case freq
   when "Y" then 12
   when "M" then 1
   else 0
   end

  end

  def totalAmount(security_deposit, registration_fee, reading_fee, magazine_fee, effective_months, unit, subscription)
    non_subsciption_unit = 1
    if subscription
      non_subsciption_unit = 0
    end

    #security_deposit + registration_fee + ((reading_fee * effective_months)/(unit + non_subsciption_unit))
    security_deposit + registration_fee + (((reading_fee+magazine_fee) * effective_months)/(unit + non_subsciption_unit))
  end

  def generateNewPlanEvent(event_type)
    eventObj = Event.new

    eventObj.event_type = event_type
    eventObj.version = "1"
    eventObj.status = "P"
    eventObj.val1 = self.id
    eventObj.val2 = self.created_by
    eventObj.val3 = self.modified_by
    eventObj.val4 = self.allow_renewal
    eventObj.val5 = self.book_return_days
    eventObj.val6 = self.category
    eventObj.val7 = self.start_date
    eventObj.val8 = self.expiry_date
    eventObj.val9 = self.frequency
    eventObj.val10 = self.home_delivery
    eventObj.val11 = self.limit_basis
    eventObj.val12 = self.magazine_fee
    eventObj.val13 = self.mandatory_months
    eventObj.val14 = self.name
    eventObj.val15 = self.num_books
    eventObj.val16 = self.num_magazines
    eventObj.val17 = self.reading_fee
    eventObj.val18 = self.reading_limit
    eventObj.val19 = self.registration_fee
    eventObj.val20 = self.restricted_to_branch
    eventObj.val21 = self.security_deposit
    eventObj.val22 = self.subscription    
    
    eventObj.save
  end
  
  private
  def set_defaults
         case self.frequency
   when "M" then self.rebate_category = 1
   when "Y" then self.rebate_category = 2
   when "N" then self.rebate_category = 3
   end
  end

end
