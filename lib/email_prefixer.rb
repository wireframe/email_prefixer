require 'email_prefixer/version'
require 'email_prefixer/configuration'
require 'email_prefixer/interceptor'
require 'email_prefixer/railtie' if defined?(Rails)

module EmailPrefixer
  class << self
    def configure
      yield configuration
      configuration
    end

    def configuration
      @configuration ||= EmailPrefixer::Configuration.new
    end
  end
end
