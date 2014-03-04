require 'lib/section'

module OmniBar

  class ShortcutSection < Section

    def initialize(shortcuts)
      @shortcuts = shortcuts

      @menu_items = shortcuts.keys.map do |title|
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
      `open #{@shortcuts[sender.title]}`
    end

  end
end

__END__
