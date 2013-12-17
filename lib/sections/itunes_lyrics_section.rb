require 'lib/section'

module OmniBar

  class ItunesLyricsSection < Section

    def initialize
      @menu_items = []
      @old_lyrics = ''
      @count = -1
    end

    def menu_items
      @menu_items
    end

    def update
      update_menu_items
    end

    private

      def retrieve_lyrics
        path = File.expand_path(File.join(File.dirname(__FILE__), "../../assets/retrieve_lyrics.rb"))
        `ruby #{path}`
      end

      def update_menu_items
        @count = (@count + 1) % 5

        return unless @count == 0

        lyrics = retrieve_lyrics.lines.to_a

        return if lyrics == @old_lyrics

        @old_lyrics = lyrics

        # Trimming blank lines
        lyrics.shift while (lyrics.first.strip.empty? && lyrics.size > 0)
        lyrics.pop while (lyrics.last.strip.empty? && lyrics.size > 0)

        @menu_items = lyrics.map do |line|
          item = NSMenuItem.new
          item.title = line
          item
        end
      end
  end
end

__END__
