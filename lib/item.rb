module OmniBar
  framework 'cocoa'

  class Item
    def initialize
      @app = NSApplication.sharedApplication

      @status_bar = NSStatusBar.systemStatusBar
      @status_item = @status_bar.statusItemWithLength(NSVariableStatusItemLength)
      @status_item.setTitle 'O'
      @status_item.highlightMode = true

      @update_mutex = Mutex.new

      @sections = []

      @menu = NSMenu.new

      @status_item.setMenu @menu
    end

    def run
      timer = NSTimer.timerWithTimeInterval(1, target: self, selector: 'update_menu', userInfo: nil, repeats: true)
      NSRunLoop.currentRunLoop.addTimer(timer, forMode:NSRunLoopCommonModes)

      @app.run
    end

    def add_section(sec)
      @sections << sec
      update_menu
    end

    def quit(sender)
      @app.terminate(self)
    end

    def update_menu
      @update_mutex.synchronize do

        @menu.removeAllItems

        # Query each section to add menu items
        @sections.each do |sec|
          sec.update

          title = sec.menubar_title
          image = sec.menubar_image

          if title
            @status_item.setTitle(title)
            @status_item.setImage(nil)
          end

          if image
            @status_item.setTitle(nil)
            @status_item.setImage(image)
          end

          sec.menu_items.each { |i| @menu.addItem i }

          # [menu insertItem:[NSMenuItem separatorItem] atIndex:index]
          @menu.addItem NSMenuItem.separatorItem
        end

        @menu.addItem(quit_menu_item)
        @menu.update
      end
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
  end

end