require 'active_support/all'

module CacheExt
  extend ActiveSupport::Concern

  class_methods do
    def cache &block
      yield
    end

    protected
    def refresh callback_name, &block
      define_method :_refresh_cache do
        # create or update cache
        # ...

        yield(self) if block_given?
      end

      self.send callback_name, :_refresh_cache
    end

    def delete callback_name, &block
      define_method :_delete_cache do
        # remove cache
        # ...

        yield(self) if block_given?
      end

      self.send callback_name, :_delete_cache
    end
  end

end

# app/models/product.rb
class Product < ApplicationRecord
  include CacheExt

  cache do
    refresh :after_save do |record|
      p "cache updated for #{record.id}"
    end

    delete :after_destroy do |record|
      p "cache delete for #{record.id}"
    end
  end

end
