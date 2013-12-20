require 'lib/section'

module OmniBar

  class XiamiClonerMonitorSection < Section

    def initialize
      load_icon('perok.png')

      @menu_items = []
      5.times { @menu_items << NSMenuItem.new }
    end

    def menubar_image
      @current_icon
    end

    def update
      update_menu_items
    end

    def menu_items
      @menu_items
    end

    private

      def update_menu_items
        logs_a = `tail -n 5 ~/Library/Logs/xiami_cloner.log`.split("\n").map { |x| x.split("\r").last }

        0.upto(4) { |i| @menu_items[i].title = (logs_a[i] || '') }

        last = logs_a[4]

        if last == '同步完成'
          load_icon('perok.png')
        elsif last == '开始同步'
          load_icon('per00.png')
        elsif /正在下载.*?/.match(last)
          load_icon('per00.png')
        elsif /#*?\w*?([0-9]*\.[0-9]*)%/.match(last)
          progress = /#*?\w*?([0-9]*\.[0-9]*)%/.match(last)[1].to_f
          i = (progress / 10).to_i
          s = i.to_s
          s = "0#{s}" if s.length == 1
          load_icon("per#{s}.png")
        end
      end

      def icon_path(name)
        File.join(File.dirname(__FILE__), "../../assets/icons/#{name}")
      end

      def load_icon(name)
        @current_icon = NSImage.new.initWithContentsOfFile(icon_path(name))
      end

  end

end
