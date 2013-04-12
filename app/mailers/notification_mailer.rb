class NotificationMailer < ActionMailer::Base
  default from: "info@mu-cre.com", to: "spot-notification@googlegroups.com"

  def event_registration_notification(event)
    @event = event
    mail( subject: "Event Registration Notification")
  end
end
