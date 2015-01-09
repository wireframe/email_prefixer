module EmailPrefixer
  class Interceptor
    def delivering_email(mail)
      mail.subject.prepend(subject_prefix)
    end
    alias_method :previewing_email, :delivering_email

    private

    def subject_prefix
      prefixes = []
      prefixes << EmailPrefixer.configuration.application_name
      prefixes << Rails.env.upcase unless Rails.env.production?
      "[#{prefixes.join(' ')}] "
    end
  end
end
