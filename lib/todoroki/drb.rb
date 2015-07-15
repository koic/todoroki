#
# USAGE:
#
# 1. client side
#
#   Todoroki::DRb.start(['小栗虫太郎', '夢野久作', '塔晶夫'], 'ja')
#   > "druby://localhost:8989'
#
# 2. server side
#
#   roulette = DRb::DRbObject.new_with_uri('druby://localhost:8989')
#   roulette.next_talker
#
require 'azuma'
require 'drb'

module Todoroki
  class DRb
    def self.start(talkers, language)
      roulette = Azuma.entry(talkers, language)

      @server = ::DRb.start_service(nil, roulette)

      puts "drb starting on #{::DRb.uri}"

      Signal.trap(:INT) do
        puts; puts('Stopping ...')

        @server.stop_service

        puts('Exiting ...'); exit!
      end

      ::DRb.uri
    end
  end
end
