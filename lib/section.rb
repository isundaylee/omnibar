module OmniBar

  class Section

    def initialize
      @first = true
    end

    def menubar_icon
      nil
    end

    def menubar_title
      nil
    end

    def changed?
      if @first
        @first = false
        return true
      else
        return false
      end
    end

    def menu_items
      @item = NSMenuItem.new

      @item.title = '什么都没有.. '
      @item.enabled = false

      [@item]
    end

  end

end