# class UserMailer < ApplicationMailer
#
#   def welcome user
#     # email setting
#   end
#
# end
#
# UserMailer.welcome(user).deliver_later
#

class Mailer

  class << self
    def method_missing(method_name, *args)
      new.send(method_name, *args)
    end
  end

  def deliver_later
    p 'deliver_later'
  end

end

class UserMailer < Mailer
  def welcome user
    p "welcome #{user}"

    self
  end
end

UserMailer.welcome("eggman").deliver_later
