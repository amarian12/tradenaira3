class IdentitiesController < ApplicationController
  before_filter :auth_anybody!, only: :new

  #include ActionView::Helpers::OutputSafetyHelper

  def new
    @identity = env['omniauth.identity'] || Identity.new
    if params[:id]
    @newid = "#{request.url}"
    @uri    = URI.parse(@newid)
  @params = CGI.parse(@uri.query)
  @id     = params['id']
    @getemailid = New.where(:id =>@id).pluck(:email)
    @getid = New.where(:id =>@id).pluck(:id)
    end
  end

  def edit
    @identity = current_user.identity
  end

  def update
    @identity = current_user.identity

    unless @identity.authenticate(params[:identity][:old_password])
      redirect_to edit_identity_path, alert: t('.auth-error') and return
    end

    if @identity.authenticate(params[:identity][:password])
      redirect_to edit_identity_path, alert: t('.auth-same') and return
    end

    if @identity.update_attributes(identity_params)
      current_user.send_password_changed_notification
      clear_all_sessions current_user.id
      reset_session
      redirect_to signin_path, notice: t('.notice')
    else
      render :edit
    end
  end

  private
  def identity_params
    params.required(:identity).permit(:password, :password_confirmation)
  end
end
