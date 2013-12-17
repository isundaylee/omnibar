require 'lib/section'

module OmniBar

  class XiamiClonerTriggerSection < Section

    def menu_items
      [trigger_menu_item]
    end

    private

      def trigger_menu_item
        return @trigger_menu_item if @trigger_menu_item

        @trigger_menu_item = NSMenuItem.new
        @trigger_menu_item.title = '同步虾米'
        @trigger_menu_item.action = 'trigger:'
        @trigger_menu_item.target = self

        @trigger_menu_item
      end

      def trigger(sender)
        source = <<EOS
tell application "Terminal"
  do script "/Users/Sunday/Programming/Git/sunutils/xm_clone_script 2>&1 | tee -a ~/Library/Logs/xiami_cloner.log; exit"
end tell
EOS

        script = NSAppleScript.alloc.initWithSource(source)
        script.executeAndReturnError(nil)
      end

  end

end
