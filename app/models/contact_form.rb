class ContactForm < MailForm::Base
  attributes :name,  validate: true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message, validate: true

  def headers
    {
      subject: "A message",
      to: "info@mu-cre.com",
      from: %("#{name}" <#{email}>)
    }
  end
end
