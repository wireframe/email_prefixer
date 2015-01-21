require 'rails_helper'

RSpec.describe EmailPrefixer::Interceptor do
  describe '#delivering_email' do
    subject(:email) { ExampleMailer.simple_mail }
    context 'when application_name is configured' do
      before do
        email.deliver_now
      end
      it 'adds prefix to delivered mail subject' do
        expect(email.subject).to eq '[CustomApp TEST] Here is the Subject'
      end
    end

    context 'when stage_name is configured' do
      before do
        @original_stage_name = EmailPrefixer.configuration.stage_name
        EmailPrefixer.configuration.stage_name = 'staging'
        email.deliver_now
      end
      after do
        EmailPrefixer.configuration.stage_name = @original_stage_name
      end
      it 'adds custom stage name to subject' do
        expect(email.subject).to eq '[CustomApp STAGING] Here is the Subject'
      end
    end

    context 'when stage_name == production' do
      before do
        @original_stage_name = EmailPrefixer.configuration.stage_name
        EmailPrefixer.configuration.stage_name = 'production'
        email.deliver_now
      end
      after do
        EmailPrefixer.configuration.stage_name = @original_stage_name
      end
      it 'does not add the stage_name to the subject' do
        expect(email.subject).to eq '[CustomApp] Here is the Subject'
      end
    end
  end
end
