# class UserWorker
#   include Sidekiq::Worker
#
#   def perform
#     # do something in async mode
#   end
#
# end
#
# UserWorker.perform_later
#

require 'active_support/all'

module Worker
  extend ActiveSupport::Concern

  class_methods do
    def perform_later
      self.new.perform
    end
  end
end

class UserWorker
  include Worker

  def perform
    'perform in UserWorker'
  end
end

p UserWorker.perform_later
