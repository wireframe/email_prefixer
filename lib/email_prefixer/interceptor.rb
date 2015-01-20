require 'active_support/core_ext/module/delegation'

module EmailPrefixer
  class Interceptor
    def delivering_email(mail)
      mail.subject.prepend(subject_prefix)
    end
    alias_method :previewing_email, :delivering_email

    private

    delegate :application_name, :stage_name, to: :configuration

    def configuration
      EmailPrefixer.configuration
    end

    def subject_prefix
      prefixes = []
      prefixes << application_name
      prefixes << stage_name.upcase unless stage_name == "production"
      "[#{prefixes.join(' ')}] "
    end
  end
end
