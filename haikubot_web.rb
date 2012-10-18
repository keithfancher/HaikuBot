#!/usr/bin/env ruby

require 'sinatra'
require 'haikubot'

WORD_LIST = 'hyph-dict'
SEP = '•'

get '/' do
  bot = HaikuBot.new(WORD_LIST, SEP)
  haiku = bot.get_haiku('<br />')
  erb :index, :locals => { :haiku => haiku }
end

get '/raw/' do
  bot = HaikuBot.new(WORD_LIST, SEP)
  bot.get_haiku
end
