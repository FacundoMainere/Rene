module Rene
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl
    enable :sessions
    enable :authentication
    enable :store_location

    #set :allow_disabled_csrf, true
    configure :development, :travis do
      use OmniAuth::Builder do
        provider :developer
      end
      set :login_page, "/login"
      ENV['APP_URL'] = 'http://127.0.0.1:3000/'
    end

    configure :staging, :production do
      use OmniAuth::Builder do
        provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_SECRET_KEY']
      end
      set :login_page, "/auth/twitter"
    end


    access_control.roles_for :any do |role|
      role.protect '/login'
    end

    get '/' do
      render 'home/index'
    end

    access_control.roles_for :any do |role|
      role.protect "/appoitment"
    end

    get :login do
      render '/home/login'
    end

    get :auth, :map => '/auth/:provider/callback' do
      auth = request.env["omniauth.auth"]
      account = Account.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
                Account.create_with_omniauth(auth)
      set_current_account(account)
      redirect "/"
    end
  end
end
