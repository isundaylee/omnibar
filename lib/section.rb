module OmniBar

  class Section

    def initialize
      @first = true
    end

    def menubar_image
      nil
    end

    def menubar_title
      nil
    end

    def update
    end

    def menu_items
      @item = NSMenuItem.new

      @item.title = '什么都没有.. '
      @item.enabled = false

      [@item]
    end

  end

end