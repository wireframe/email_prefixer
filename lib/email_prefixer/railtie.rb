module EmailPrefixer
  class Railtie < ::Rails::Railtie
    config.action_mailer.register_interceptor EmailPrefixer::Interceptor.new

    initializer 'email_prefixer.configure_default_application_name' do
      EmailPrefixer.configure do |config|
        config.application_name = app.class.parent_name
      end
    end
  end
end
