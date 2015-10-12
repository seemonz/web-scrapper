require_relative 'post'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'colorize'

@post = Post.new(ARGV[0])
@post.get_authors
@post.get_comments
@post.merge
@post.add_hash

def print_it
  puts
  puts @post.title.colorize(:cyan)
  puts @post.url.colorize(:light_green)
  puts @post.points.colorize(:light_yellow)
  puts
  @post.arr_comments.each do |comment|
    puts comment.author.colorize(:light_red)
    puts comment.comment.colorize(:light_blue)
  end
end

print_it
