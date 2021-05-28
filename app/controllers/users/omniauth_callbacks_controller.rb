
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    handl_oauth("Google")
  end

  def github
    handl_oauth("Github")
  end

  def facebook
    handl_oauth("Facebook")
  end

  def handl_oauth(kind)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

end