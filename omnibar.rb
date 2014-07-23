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
require 'lib/sections/balance_meter_section'

item = OmniBar::Item.new

item.add_section(OmniBar::BalanceMeterSection.new({
  'Qujing' => 'qujing'
}))

# item.add_section(OmniBar::TimeSection.new)
item.add_section(OmniBar::XiamiClonerTriggerSection.new)
item.add_section(OmniBar::XiamiClonerMonitorSection.new)
item.add_section(OmniBar::ItunesLyricsSection.new)

item.add_section(OmniBar::ShortcutSection.new({
  '单词列表' => '~/Dropbox/Synced/Vocabulary',
  '虾米播放列表' => '~/Dropbox/Synced/Playlist',
  '虾米已导入列表' => '~/Dropbox/Synced/Cloned',
  'Logic 导出目录' => '~/Music/Logic/Bounces',
}))

item.run