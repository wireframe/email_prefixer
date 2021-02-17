module EmailPrefixer
  class Railtie < ::Rails::Railtie
    initializer 'email_prefixer.configure_defaults' do |app|
      config = EmailPrefixer.configure do |config|
        config.application_name ||= if app.class.respond_to?(:module_parent_name)
            app.class.module_parent_name
          else
            app.class.parent_name
          end
        config.stage_name ||= Rails.env
        config.builder ||= EmailPrefixer::Configuration::DEFAULT_BUILDER
      end
      interceptor = EmailPrefixer::Interceptor.new(config)
      ActiveSupport.on_load :action_mailer do
        register_preview_interceptor(interceptor)
        register_interceptor(interceptor)
      end
    end
  end
end
