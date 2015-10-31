module EmailPrefixer
  class Configuration
    attr_accessor :application_name, :stage_name, :subject_format

    def subject_format
      @subject_format ||= default_format
    end

    private

    def default_format
      ->(application_name, stage_name, subject) {
        mail_prefix = [].tap do |prefixes|
          prefixes << application_name
          prefixes << stage_name.upcase unless stage_name == 'production'
        end.join(' ')

        "[#{mail_prefix}] #{subject}"
      }
    end
  end
end
