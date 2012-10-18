#!/usr/bin/env ruby

require 'sinatra'
require 'haikubot'

get '/' do
  bot = HaikuBot.new('hyph-dict', 165.chr)
  bot.get_haiku
  erb :index
end
