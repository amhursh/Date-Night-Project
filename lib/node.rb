class Node

  attr_reader :score,
              :title,
              :info

  attr_accessor :depth,
                :left,
                :right

  def initialize(score, title, depth)
    @score = score
    @title = title
    @depth = depth
    @left = nil
    @right = nil
    @info = { title => score }
  end


end
