module EmailPrefixer
  class Railtie < ::Rails::Railtie
    initializer 'email_prefixer.configure_defaults' do |app|
      config = EmailPrefixer.configure do |config|
        config.application_name ||= app.class.parent_name
        config.stage_name ||= Rails.env
        config.builder ||= EmailPrefixer::Configuration::DEFAULT_BUILDER
      end
      interceptor = EmailPrefixer::Interceptor.new(config)
      ActionMailer::Base.register_preview_interceptor(interceptor)
      ActionMailer::Base.register_interceptor(interceptor)
    end
  end
end
