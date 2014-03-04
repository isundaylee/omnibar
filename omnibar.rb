#!/usr/bin/env macruby
# encoding: utf-8

libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'lib/item'
require 'lib/section'

require 'lib/sections/xiami_cloner_monitor_section'
require 'lib/sections/itunes_lyrics_section'
require 'lib/sections/xiami_cloner_trigger_section'
require 'lib/sections/time_section'
require 'lib/sections/shortcut_section'

item = OmniBar::Item.new

# item.add_section(OmniBar::TimeSection.new)
item.add_section(OmniBar::XiamiClonerTriggerSection.new)
item.add_section(OmniBar::XiamiClonerMonitorSection.new)
item.add_section(OmniBar::ItunesLyricsSection.new)

item.add_section(OmniBar::ShortcutSection.new({
  'Vocabulary List' => '~/Dropbox/Synced/Vocabulary',
  'Xiami Playlist' => '~/Dropbox/Synced/Playlist',
  'Xiami Cloned List' => '~/Dropbox/Synced/Cloned'
}))

item.run