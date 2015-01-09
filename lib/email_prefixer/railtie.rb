module EmailPrefixer
  class Railtie < ::Rails::Railtie
    initializer 'email_prefixer.configure_default_application_name' do |app|
      ActionMailer::Base.register_interceptor(EmailPrefixer::Interceptor.new)
      EmailPrefixer.configure do |config|
        config.application_name ||= app.class.parent_name
      end
    end
  end
end
