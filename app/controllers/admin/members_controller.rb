module Admin
  class MembersController < BaseController
    load_and_authorize_resource

    def index
      @search_field = params[:search_field]
      @search_term = params[:search_term]
      @members = Member.search(field: @search_field, term: @search_term).page(params[:page]).per(50)
    end

    def show
      @account_versions = AccountVersion.where(account_id: @member.account_ids).order(:id).reverse_order.page params[:page]
    end

    def edit
       @member = Member.find(params[:id])
    end

    def manage
      doaction  = params[:doaction]
      mtype     = params[:mtype]
      member = Member.find_by_id(params[:id])
      last_membership = member.membership
      

      if doaction == "toggle-trader"
        if member.membership.nil? || member.membership != mtype
          member.membership = mtype.to_sym
        else
          member.membership = nil
        end
        if member.save
          UserMailer.trader(member,last_membership).deliver
          flash[:notice] = "Last action was success!"
        else
          flash[:alert] = member.errors.full_messages.join(", ")
        end
         
      end
      redirect_to :back
    end

    def update
      if @member.update(subscriber_member)
        flash[:notice] = 'success'  
        redirect_to admin_member_path
        return false
      end
    end

    def lock_user 
      #puts Identity.find_by_email(@member.email).inspect
      identity = Identity.find_by_email(@member.email)
      unless identity.nil?
        if params[:block] == "false"
          identity.is_locked = nil
          identity.locked_at = nil
        else
          identity.is_locked = true
          identity.locked_at = DateTime.now
        end

        if identity.save(validate: false)
          flash[:notice] = 'success'
        else
          flash[:notice] = 'Failed'
        end
      else
        flash[:notice] = 'Failed'
      end
      
      redirect_to admin_member_path
    end

    def toggle
      if params[:api]
        @member.api_disabled = !@member.api_disabled?
      else
        @member.disabled = !@member.disabled?
      end
      @member.save
    end

    def active
      @member.update_attribute(:activated, true)
      @member.save
      redirect_to admin_member_path(@member)
    end
private 

def subscriber_member
      params.require(:member).permit(:name,:email,:phone_number,:notes,:created_at)
    end
  end
end
