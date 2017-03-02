module WRKFLO
  module Notifier
    FOOTER_TEXT = <<-END_FOOTER
Run `wrkflo --help` for usage information.
    END_FOOTER

    # Write an error message to stderr and abort execution, exiting with the
    # given status code, or `1` if no status code is specified.
    def self.error_out *messages, type: "Error", status: 1
      $stderr.puts "#{type}: #{messages.first}"
      messages.drop(1).each{ |msg| $stderr.puts "\t#{msg}" }
      $stderr.puts FOOTER_TEXT
      exit status
    end

    # Write an arbitrary message to stdout.
    def self.log message
      $stdout.puts message
    end
  end
end
