require 'rails_helper'

RSpec.describe EmailPrefixer::Interceptor do
  describe '#delivering_email' do
    subject(:email) { ExampleMailer.simple_mail }

    context 'without configuration' do
      it 'uses default app name to mail subject' do
        email.deliver_now

        expect(email.subject).to eq '[Dummy TEST] Here is the Subject'
      end
    end

    context 'with default format' do
      context 'when application_name is configured' do
        before do
          @original_app_name = EmailPrefixer.configuration.application_name
          EmailPrefixer.configuration.application_name = 'CustomApp'
          email.deliver_now
        end

        after do
          EmailPrefixer.configuration.application_name = @original_app_name
        end

        it 'adds custom app name to mail subject' do
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
          expect(email.subject).to eq '[Dummy STAGING] Here is the Subject'
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
          expect(email.subject).to eq '[Dummy] Here is the Subject'
        end
      end
    end

    context 'with a custom format as string' do
      before do
        @original_subject_format = EmailPrefixer.configuration.subject_format
        EmailPrefixer.configuration.subject_format = "** %{application_name} %{stage_name} ** %{subject}"
        email.deliver_now
      end

      after do
        EmailPrefixer.configuration.subject_format = @original_subject_format
      end

      it 'formats subject as specified' do
        expect(email.subject).to eq '** Dummy test ** Here is the Subject'
      end
    end

    context 'with a custom format as lambda' do
      before do
        @original_subject_format = EmailPrefixer.configuration.subject_format
        EmailPrefixer.configuration.subject_format = ->(application_name, stage_name, subject) {
          "#{subject} - #{application_name} | #{stage_name.upcase}"
        }

        email.deliver_now
      end

      after do
        EmailPrefixer.configuration.subject_format = @original_subject_format
      end

      it 'formats subject as specified' do
        expect(email.subject).to eq 'Here is the Subject - Dummy | TEST'
      end
    end

    context 'with an unsupported custom format' do
      before do
        @original_subject_format = EmailPrefixer.configuration.subject_format
        EmailPrefixer.configuration.subject_format = Object.new

        email.deliver_now
      end

      after do
        EmailPrefixer.configuration.subject_format = @original_subject_format
      end

      it 'uses no formatting' do
        expect(email.subject).to eq 'Here is the Subject'
      end
    end
  end
end
