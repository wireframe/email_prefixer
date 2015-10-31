module EmailPrefixer
  class Interceptor
    extend Forwardable
    def_delegators :configuration, :application_name, :stage_name, :subject_format

    def initialize
      @configuration = EmailPrefixer.configuration
    end

    def delivering_email(mail)
      mail.subject = prepare_subject(mail)
    end
    alias_method :previewing_email, :delivering_email

    private

    attr_reader :configuration

    def prepare_subject(mail)
      if subject_format.respond_to? :call
        subject_format.call(application_name, stage_name, mail.subject)
      elsif subject_format.is_a? String
        format(subject_format, {application_name: application_name, stage_name: stage_name, subject: mail.subject})
      else
        mail.subject
      end
    end
  end
end
