require 'rails_helper'

RSpec.describe EmailPrefixer::Interceptor do
  describe '#delivering_email' do
    before do
      ExampleMailer.simple_mail.deliver
    end
    it 'adds prefix to delivered mail subject' do
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq '[CustomApp TEST] Here is the Subject'
    end
  end
end
