class BaseMailer < ActionMailer::Base
  default from: Rails.configuration.mail_from
end
