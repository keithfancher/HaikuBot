#!/usr/bin/env ruby

require 'sinatra'
require 'haikubot'

get '/' do
  bot = HaikuBot.new('hyph-dict', 165.chr)
  haiku = bot.get_haiku('<br />')
  erb :index, :locals => { :haiku => haiku }
end

get '/raw/' do
  bot = HaikuBot.new('hyph-dict', 165.chr)
  bot.get_haiku
end
