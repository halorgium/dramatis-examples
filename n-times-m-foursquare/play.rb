#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__) + '/../dramatis/lib'
require 'dramatis'
require 'dramatis/actor'
require 'set'

$:.unshift File.dirname(__FILE__) + '/lib'
require 'round'
require 'player'

players_count = ARGV.shift.to_i
rounds_count = ARGV.shift.to_i
puts "Running with #{players_count} players, #{rounds_count} rounds"

players = []
players_count.times do |i|
  players << Player.new("player-#{i}")
end
puts

rounds = []
rounds_count.times do |i|
  set = Set.new
  (rand(30).to_i + 5).times do
    set << players[rand(players.size)]
  end
  rounds << Round.new("round-#{i}", set.to_a)
end

rounds.each do |r|
  r.play
end

until rounds.all? {|r| r.finished?}
  puts "Waiting"
  sleep 1
end
