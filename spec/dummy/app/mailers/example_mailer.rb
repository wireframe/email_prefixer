class ExampleMailer < ActionMailer::Base
  def simple_mail
    mail(
      to: 'someone@somewhere.com',
      from: 'someoneelse@somewhere.com',
      subject: 'Here is the Subject',
      body: 'hello'
    )
  end
end
