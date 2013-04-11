class NotificationMailer < ActionMailer::Base
  default from: "info@mu-cre.com"
  default to: "mu-cre@googlegroups.com"

  def event_registration_notification(event)
    @event = event
    mail( subject: "Event Registration Notification")
  end
end
