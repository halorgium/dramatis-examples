#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__) + '/../dramatis/lib'
require 'dramatis'
require 'dramatis/actor'
require 'set'

$:.unshift File.dirname(__FILE__) + '/lib'
require 'round'
require 'player'
require 'manager'

players_count = ARGV.shift.to_i
rounds_count = ARGV.shift.to_i
puts "Running with #{players_count} players, #{rounds_count} rounds"

players = []
players_count.times do |i|
  players << Player.new("player-#{i}")
end

Manager.new(rounds_count, players)
