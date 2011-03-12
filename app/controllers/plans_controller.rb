class PlansController < ApplicationController
  def index
    # for some reason cookie overflow comes without dup (TODO)
    branch = user_session['current_branch'].dup
    
    # ordered by name of plans
    @plans = branch.plans.order('name')
  end
  
  def show
    @plan = Plan.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @plan = Plan.new(params[:plan]) do |q|
      q.created_by = current_user.id
      q.modified_by = current_user.id      
    end

    respond_to do |format|
     if @plan.save
       format.html { redirect_to(plans_overview_path, :notice => 'Plan was successfully created.') }
     else
       format.html { render :action => "new" }
     end
   end
  end

  def new
    @plan = Plan.new
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    # habtm check - boxes null check
    params[:plan][:branch_ids] ||=[]
    params[:plan][:coupon_ids] ||=[]
    
    @plan = Plan.find(params[:id])    
    if @plan.update_attributes(params[:plan])
      @plan.update_attribute('modified_by', current_user.id)
      redirect_to :action => 'show', :id => @plan
    else
      render :action => 'edit'
    end
  end

  def destroy
    planObj = Plan.find(params[:id])
    planObj.update_attribute('modified_by', current_user.id)
    planObj.destroy

    respond_to do |format|
     format.html { redirect_to(plans_overview_path) }
     format.xml  { head :ok }
   end
  end

  def overview
    @planlist = Plan.find(:all, :order => 'id DESC')
  end  

  def plandetails
    @plan = Plan.find(params[:plan_id])

     unit = @plan.decodefrequency(@plan.frequency)
    @signupmonths = unit
     rebate = Rebate.find_by_category_and_membership_months(@plan.rebate_category, @signupmonths)
     rebate_months = rebate.rebate_months
     effective_months = @signupmonths - rebate_months
    @totalamount = @plan.totalAmount(@plan.security_deposit, @plan.registration_fee, @plan.reading_fee, @plan.magazine_fee, effective_months, unit, @plan.subscription)
    render :partial=>"plandetails"
 end

 def paymentdetails
     @plan = Plan.find(params[:plan_id])
     @signupmonths = params[:signup_months].to_i
     unit = @plan.decodefrequency(@plan.frequency)

     rebate = Rebate.find_by_category_and_membership_months(@plan.rebate_category, @signupmonths)
     rebate_months = rebate.rebate_months
     effective_months = @signupmonths - rebate_months
     @totalamount = @plan.totalAmount(@plan.security_deposit, @plan.registration_fee, @plan.reading_fee, @plan.magazine_fee, effective_months, unit, @plan.subscription)
     render :partial=>"plandetails"
 end
  
end
