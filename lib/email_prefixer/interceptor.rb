module EmailPrefixer
  class Interceptor
    def delivering_email(mail)
      mail.subject.prepend(email_prefix)
    end

    private

    def email_prefix
      prefixes = []
      prefixes << EmailPrefixer.configuration.application_name
      prefixes << Rails.env.upcase unless Rails.env.production?
      "[#{prefixes.join(' ')}] "
    end

    def application_name
      EmailPrefixer.configuration.application_name || Rails.application.class.parent_name
    end
  end
end
