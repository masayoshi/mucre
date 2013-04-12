class NotificationMailer < ActionMailer::Base
  default from: "info@mu-cre.com", to: "info@mu-cre.com"

  def event_registration_notification(event)
    @event = event
    mail( subject: "Event Registration Notification")
  end

  def test_event_registration_notification(event, email)
    @event = event
    mail( to: email, subject: "Event Registration Notification")
  end
end
