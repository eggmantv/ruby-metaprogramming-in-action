require 'active_support/all'

module ActsAsField
  def self.included base
    base.send :extend, ClassMethods

    base.class_eval do
      cattr_accessor :acts_as_fields
      self.acts_as_fields = []
    end
  end

  module ClassMethods
    def field name, path
      self.acts_as_fields << name.to_sym

      define_method(name) do
        case path
        when String
          path.split(".").inject(self.raw_data) { |data, key| data[key] }
        when Proc
          path.call(self)
        end
      end
    end
  end
end

class Product
  include ActsAsField

  field :title, "data.title"
  field :power, "meta.power"
  field :duration, "meta.duration"
  field :power_usage, proc { |record| record.power / record.duration }

  def raw_data
    {
      "data" => {
        "title" => "switch 1"
      },
      "meta" => {
        "power" => 200,
        "duration" => 20
      }
    }
  end
end

product = Product.new
p product.title
p product.power
p product.power_usage
