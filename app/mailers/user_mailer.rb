class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'users/mailer' # to make sure that your mailer uses the devise views


  def welcome_reset_password_instructions(user)
    create_reset_password_token(user)
    mail(to: user.email, subject: 'Welcome to the New Site')
  end



          def reset_password_instructions(record, token, opts={})
             mail = super
             # your custom logic
             mail.subject = t("reset_link")
             mail
           end

           def default_url_options
             {
               :locale => I18n.locale.to_s,
               :host => "https://k7gram.herokuapp.com"          
             }
           end


  private

  def create_reset_password_token(user)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    @token = raw
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
  end
end
