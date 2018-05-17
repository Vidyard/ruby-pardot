require 'cgi'

module Pardot
  module Escape
    def self.escape(value)
      CGI.escape value if value
    end
  end
end
