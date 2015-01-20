require 'rails_helper'

RSpec.describe EmailPrefixer::Interceptor do
  describe '#delivering_email' do
    it 'adds prefix to delivered mail subject' do
      ExampleMailer.simple_mail.deliver
      expect(last_email.subject).to eq '[CustomApp TEST] Here is the Subject'
    end

    it 'enables customizing the environment name' do
      original_stage_name, EmailPrefixer.configuration.stage_name = EmailPrefixer.configuration.stage_name, 'staging'

      ExampleMailer.simple_mail.deliver

      expect(last_email.subject).to eq '[CustomApp STAGING] Here is the Subject'

      EmailPrefixer.configuration.stage_name = original_stage_name
    end

    def last_email
      ActionMailer::Base.deliveries.last
    end
  end
end
