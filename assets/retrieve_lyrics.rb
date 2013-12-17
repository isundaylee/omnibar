#!/usr/bin/env ruby
# encoding: utf-8

require 'bundler/setup'

class LyricsRetriever

  def self.retrieve_lyrics(path)

    require 'taglib'

    # TagLib::MPEG::File.open(path) do |f|
    #   tag = f.id3v2_tag
    #   tag.frame_list('TRCK').first
    # end

    if File.extname(path) == '.mp3'
      TagLib::MPEG::File.open(path) do |f|
        tag = f.id3v2_tag
        return tag.frame_list('USLT').first.to_s if tag.frame_list('USLT')
      end
    else
      TagLib::MP4::File.open(path) do |f|
        return f.tag.item_list_map['©lyr'].to_string_list[0] if f.tag.item_list_map['©lyr']
      end
    end
  end
end

scpt_path = File.expand_path(File.join(File.dirname(__FILE__), 'get_path.scpt'))
path = `osascript #{scpt_path}`.strip
exit if path.empty?
lyrics = LyricsRetriever.retrieve_lyrics(path)
puts lyrics