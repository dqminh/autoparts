module Autoparts
  module Commands
    class Restart
      def initialize(args, options)
        if args.empty?
          abort <<-EOS.unindent
            Usage: parts restart PACKAGE...
            Example: parts restart postgresql
          EOS
        end
        begin
          args.each do |package_name|
            package = Package.factory(package_name)
            puts "=> Stopping #{package_name}..."
            package.stop
            puts "=> Starting #{package_name}..."
            package.start
            puts "=> Restarted: #{package_name}"
          end
        rescue => e
          abort "parts: ERROR: #{e}\nAborting!"
        end
      end
    end
  end
end
