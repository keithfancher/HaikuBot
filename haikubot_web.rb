#!/usr/bin/env ruby

require 'sinatra'
require 'haikubot'

get '/' do
  bot = HaikuBot.new('hyph-dict', 165.chr)
  haiku = bot.get_haiku('<br />')
  erb :index
end
