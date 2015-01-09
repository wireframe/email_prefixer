module EmailPrefixer
  class Railtie < ::Rails::Railtie
    initializer 'email_prefixer.configure_default_application_name' do |app|
      interceptor = EmailPrefixer::Interceptor.new
      ActionMailer::Base.register_preview_interceptor(interceptor)
      ActionMailer::Base.register_interceptor(interceptor)
      EmailPrefixer.configure do |config|
        config.application_name ||= app.class.parent_name
      end
    end
  end
end
