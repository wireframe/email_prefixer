module EmailPrefixer
  class Interceptor
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def delivering_email(mail)
      prefix = configuration.builder.call
      mail.subject.prepend(prefix)
    end
    alias_method :previewing_email, :delivering_email
  end
end
