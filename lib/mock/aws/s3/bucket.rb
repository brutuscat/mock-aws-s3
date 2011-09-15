require 'pathname'

module AWS
  module S3
    class Bucket
      class << self
        def create(name, options = {})
          # Do nothing
        end

        def find(name = nil, options = {})
          path  = S3Object.path!(name, "/")
          files = Dir.glob("#{path}/**/*").
            select  { |f| File.file?(f) }.
            collect { |f| Pathname.new(f).relative_path_from(Pathname.new(path)) }.
            collect { |f| {:bucket => name, 'key' => "/#{f}"} }
          new('name' => name, 'contents' => files)
        end
      end
    end
  end
end
