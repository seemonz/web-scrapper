require 'rubygems'
require 'nokogiri'
require 'pry'
require_relative 'comment'
require 'open-uri'

class Post
  attr_reader :doc, :title, :url, :points, :item_id, :arr_comments, :authors

  def initialize(html)
    @doc = Nokogiri::HTML(open(html))
    @title = @doc.css('title')[0].text
    @url = @doc.css('td.title a')[0]['href']
    @points = @doc.css('.score')[0].text
    @item_id = @doc.css('a#up_7663775')[0]['id']
    @arr_comments = []
  end

  def get_authors
    authors = @doc.search('.comhead a:first-child').map { |font| font.inner_text} [1..-1]
  end

  def get_comments
    comments = @doc.search('.comment').map { |font| font.inner_text}
    comments.each {|a| a.gsub!(/[..\s*]+[..\s*..\s*(-----).*]/, '') }
  end

  # push authors and comments into a hash, authors => comments, it worked!!!
  def merge
    authors = get_authors
    comments = get_comments
    @hash = Hash[authors.zip(comments)]
  end

  # takes the hash and puts the authors and comments into a new comment
  def add_hash
    merge.each do |author, comment|
      @arr_comments << Comment.new(author, comment)
    end
  end

end
