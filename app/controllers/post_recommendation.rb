#!/usr/bin/env ruby

class Post < Struct.new(:title)
  def words
    @words ||= self.title.gsub(/[a-zA-Z]{3,}/).map(&:downcase).uniq.sort
  end
end


class PostRecommender
  def initialize post, posts
    @post, @posts = post, posts
  end

  def recommendations
    @posts.map! do |this_post|
      this_post.define_singleton_method(:jaccard_index) do @jaccard_index
    end

    this_post.define_singleton_method("jaccard_index=") do |index|
      @jaccard_index = index || 0.0
    end

    intersection = (@post.words & this_post.words).size
    union = (@post.words | this_post.words).size

    this_post.jaccard_index = (intersection.to_f / union.to_f) rescue 0.0
    this_post

    end.sort_by { |post| 1 - post.jaccard_index }
  end
end


# Load posts from this file to recommend
DATA = File.new("D:\\MastersProject\\recommender\\posts.txt", "r")
POSTS = DATA.read.split("\n").map { |l| Post.new(l) }

# Create initial post
this_post = Post.new("C++ programming language")

# Load recommender
recommender = PostRecommender.new(this_post, POSTS)

# Find recommendations
recommended_posts = recommender.recommendations

# Show posts that match the most
recommended_posts.each do |post|
  if post.jaccard_index > 0
    puts "#{post.title} (#{'%.2f' % post.jaccard_index})"
  end
end

class StoreInFile
  def add
    open("..\\posts.txt", "a") do |f|
      f << @post.heading+"\n"
    end
  end
end
