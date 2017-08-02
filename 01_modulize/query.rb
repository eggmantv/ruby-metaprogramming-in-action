require 'active_support/all'

# app/models/product.rb
class Product
end

# lib/searching/query.rb
module Searching
  module Query
    def self.define model, &block
      klass = model.to_s.constantize
      klass.instance_eval(&block)

      klass.extend ClassMethods
    end

    module ClassMethods
      def search
        # search...
        search_cond
      end

      def search_cond options = {}
        # default searching options
        options
      end
    end

  end
end

# app/indices/product_indexer.rb
Searching::Query.define :Product do
  def search_cond options = {}
    options.reverse_merge!(status: 1)
  end
end

p Product.search
