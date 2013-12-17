module OmniBar
  framework 'cocoa'

  class Item
    def initialize
      @app = NSApplication.sharedApplication

      @status_bar = NSStatusBar.systemStatusBar
      @status_item = @status_bar.statusItemWithLength(NSVariableStatusItemLength)
      @status_item.setTitle 'O'

      @sections = []

      @menu = NSMenu.new
      update_menu

      @status_item.setMenu @menu
    end

    def run
      @app.run
    end

    def add_section(sec)
      @sections << sec
      update_menu
    end

    def quit(sender)
      @app.terminate(self)
    end

    private

      def quit_menu_item
        return @quit_menu_item if @quit_menu_item

        @quit_menu_item = NSMenuItem.new
        @quit_menu_item.title = '退出'
        @quit_menu_item.action = 'quit:'
        @quit_menu_item.target = self
        @quit_menu_item.enabled = true

        @quit_menu_item
      end

      def update_menu
        @menu.removeAllItems
        @menu_items_cache = {} unless @menu_items_cache

        # Query each section to add menu items
        @sections.each do |sec|
          title = sec.menubar_title
          icon = sec.menubar_icon

          @menu_items_cache[sec] = [] unless @menu_items_cache[sec]

          @status_item.setTitle(title) if title
          @status_item.setIcon(icon) if icon

          @menu_items_cache[sec] = sec.menu_items
          @menu_items_cache[sec].each { |i| @menu.addItem i }

          # [menu insertItem:[NSMenuItem separatorItem] atIndex:index]
          @menu.addItem NSMenuItem.separatorItem
        end

        @menu.addItem(quit_menu_item)
      end
  end

end