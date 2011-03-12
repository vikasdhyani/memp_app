class SignupsReportController < ApplicationController
  def signups_report
    respond_to do |format|
      format.html
    end
  end

  def report_details
    branch_id = params[:branch_id].to_i
    modifyMode = params[:modifyMode]
    start_date = params[:start_date]
    end_date = params[:end_date]
    query_text = params[:query_text]

    # whitelist : data selected for display
    selectedCol = ["flag_migrated", "payment_ref", "payment_mode", "security_deposit", "registration_fee",
              "reading_fee", "discount", "paid_amt", "coupon_amt", "coupon_no", "coupon_id",
              "plan_id", "application_no", "membership_no", "employee_no",
              "referrer_member_id", "email", "lphone", "mphone", "address", "name", "id"]

    unless branch_id.nil?      
      if modifyMode == 'T'
        if query_text.nil?
          @detailObj = Signup.find(:all, :conditions =>
          ["branch_id = ? AND created_at >= to_date(?, 'DD-MM-YY') AND
          created_at <= (to_date(?, 'DD-MM-YY') + 1) AND membership_no != '-'",
          branch_id, start_date, end_date], :select => selectedCol)
        else
          @detailObj = Signup.find(:all, :conditions =>
          ["branch_id = ? AND (lower(membership_no) LIKE ? OR lower(name) LIKE ?)",
          branch_id, '%' + query_text.to_s.downcase + '%', '%' +
          query_text.to_s.downcase + '%'], :select => selectedCol)          
        end
      end
    end

    render :partial => 'reportDetails'
  end

  def newMemberReversal
    signup_id = params[:signup_id]
    @signup = Signup.find(signup_id)

    if @signup.update_attribute("flag_reversed", "Y")
      @reportMsg = 'New Member Reversal done for : ' + @signup.membership_no
    else
      @reportMsg = 'New Member Reversal failed for : ' + @signup.membership_no
    end

    render :partial => 'reportMsg'
  end

  def reSendWelcomeMail
    signup = Signup.find(params[:signup_id])
    SignupMailer.registration_confirmation(signup).deliver
    @reportMsg = 'Welcome Mail sent to : ' + signup.membership_no

    render :partial => 'reportMsg'
  end

  def rePrintReceipt
    @signup = Signup.find(params[:signup_id])

    render :partial => 'rePrintReceipt'
  end

end
