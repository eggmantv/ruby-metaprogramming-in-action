# sprockets gem monkey patch

# config/initializers/exclude_minify.rb
module Sprockets
  module Loader
    private
    def call_processors(processors, input)
      _, logical_path = paths_split(config[:paths], input[:filename])

      if ::Rails.configuration.exclude_js_compress_files.include?(logical_path)
        puts "Skipping compress file: #{logical_path}"
        processors = Array.new(processors).delete_if { |processor| processor.to_s =~ /uglifier/i }
      end

      super(processors, input)
    end

  end
end

# config/initializers/assets.rb
Rails.application.configure do
  config.exclude_js_compress_files = %w[
    app/common.js
  ]
end
