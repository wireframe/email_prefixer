require 'rails_helper'

RSpec.describe EmailPrefixer::Interceptor do
  describe '#delivering_email' do
    subject(:email) { ExampleMailer.simple_mail }
    context 'when application_name and stage_name is configured' do
      before do
        EmailPrefixer.configuration.application_name = 'CustomApp'
        EmailPrefixer.configuration.stage_name = 'staging'
        email.deliver_now
      end
      it 'adds prefix to mail subject' do
        expect(email.subject).to eq '[CustomApp STAGING] Here is the Subject'
      end
    end
  end
end
