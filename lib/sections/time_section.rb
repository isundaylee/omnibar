require 'lib/section'

module OmniBar

  class TimeSection < Section

    def menu_items
      @item = NSMenuItem.new

      @item.title = Time.now.to_s
      @item.enabled = false

      [@item]
    end

  end

end
