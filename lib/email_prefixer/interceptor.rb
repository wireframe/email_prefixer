module EmailPrefixer
  class Interceptor
    extend Forwardable
    def_delegators :@configuration, :application_name, :stage_name

    def initialize
      @configuration = EmailPrefixer.configuration
    end

    def delivering_email(mail)
      mail.subject.prepend(subject_prefix)
    end
    alias_method :previewing_email, :delivering_email

    private

    def subject_prefix
      prefixes = []
      prefixes << application_name
      prefixes << stage_name.upcase unless stage_name == 'production'
      "[#{prefixes.join(' ')}] "
    end
  end
end
