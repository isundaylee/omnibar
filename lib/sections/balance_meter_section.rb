require 'lib/section'

module OmniBar

  class BalanceMeterSection < Section

    BALANCE_METER_PATH = File.expand_path('~/Programming/Git/balance_meter/')

    def initialize(names)
      @names = names

      @menu_items = @names.map do |title, name|
        item = NSMenuItem.new

        item.title = title
        item.action = 'trigger:'
        item.target = self

        item
      end
    end

    def menu_items
      @menu_items
    end

    def update
    end

    def trigger(sender)
      title = sender.title.split(':')[0]
      `cd #{BALANCE_METER_PATH} && ./balance update #{@names[title]}`
      full_answer = `cd #{BALANCE_METER_PATH} && ./balance read #{@names[title]}`

      answer = full_answer.lines.first
      date_updated = full_answer.lines.to_a[1] if full_answer.lines.to_a.size >= 2

      puts date_updated

      sender.title = "#{title}: #{answer} at #{date_updated}"
    end

  end
end

__END__
