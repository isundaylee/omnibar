#!/usr/bin/env macruby
# encoding: utf-8

require 'lib/item.rb'
require 'lib/section.rb'

item = OmniBar::Item.new

item.add_section(OmniBar::Section.new)

item.run