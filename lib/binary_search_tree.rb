require_relative '../lib/node'

require 'pry'

class BinarySearchTree

  attr_reader :root

  def initialize
    @root = nil
  end

  def create_root(score, title, depth)
    if empty?
      @root = Node.new(score, title, depth = 0)
    end
  end

  def empty?
    @root == nil
  end

  def root_depth
    @root.depth
  end

  def insert(score, title)
    depth = 0
    current_node = @root
    while current_node != nil
      if (score < current_node.score) && (current_node.left == nil)
        depth += 1
        current_node.left = Node.new(score, title, depth)
        return current_node.left.depth
      elsif (score > current_node.score) && (current_node.right == nil)
        depth += 1
        current_node.right = Node.new(score, title, depth)
        return current_node.right.depth
      elsif (score < current_node.score)
        depth += 1
        current_node = current_node.left
      elsif (score > current_node.score)
        depth += 1
        current_node = current_node.right
      else
        return
      end
    end
    create_root(score, title, depth)
    root.depth
  end

  def include?(desired_node_score, node = @root)
    return false if (node == nil)
    if desired_node_score < node.score
      include?(desired_node_score, node.left)
    elsif desired_node_score > node.score
      include?(desired_node_score, node.right)
    else
      true
    end
  end

  def depth_of(desired_node_score, node = @root)
    return nil if node == nil
    if desired_node_score < node.score
      depth_of(desired_node_score, node.left)
    elsif desired_node_score > node.score
      depth_of(desired_node_score, node.right)
    else
      node.depth
    end
  end

  def sort(node = @root, sort_results = [])
    return nil if (node == nil)
    sort(node.left, sort_results) if node.left != nil
    sort_results << node.info
    sort(node.right, sort_results) if node.right != nil
    sort_results
  end

  def min(node = @root)
    return node.info if (node.left == nil)
    while node.left != nil
      node = node.left
    end
    node.info
  end

  def max(node = @root)
    return node.info if (node.right == nil)
    while node.right != nil
      node = node.right
    end
    node.info
  end

  def load(file_name)
    load_list = []
    count = 0
    file_open_and_split(file_name, load_list)
    convert_string_to_integer(load_list)
    load_list_to_tree(load_list, count)
  end

  def load_list_to_tree(load_list, count)
    load_list.each do |score, title|
      if include?(score) == false
        insert(score, title)
        count += 1
      end
    end
    count
  end

  def file_open_and_split(file_name, load_list)
    File.open(file_name) do |x|
      x.each_line.each do |line|
        load_list << line.strip.split(", ", 2)
      end
    end
  end

  def convert_string_to_integer(load_list)
    load_list.map do |pair|
      pair[0] = pair[0].to_i
    end
  end

  def return_nodes_at_given_level(desired_depth, node = @root, sort_results = [])
    return sort_results if (node == nil)
    return_nodes_at_given_level(desired_depth, node.left, sort_results) if node.left != nil
    sort_results << node.score if (node.depth == desired_depth)
    return_nodes_at_given_level(desired_depth, node.right, sort_results) if node.right != nil
    sort_results
  end

  def set_root_equal_to_desired_node(desired_node_score, current_node = @root)
    while desired_node_score != current_node.score
      if desired_node_score < current_node.score
        current_node = current_node.left
      elsif desired_node_score > current_node.score
        current_node = current_node.right
      else
        return
      end
    end
    return current_node
  end

  def sort_child_nodes_and_convert_to_total(node)
    sort(node).count
  end

  def find_total_child_nodes_for_each_node_at_a_given_depth(depth)
    child_output = []
    return_nodes_at_given_level(depth).each do |x|
    child_output  << sort_child_nodes_and_convert_to_total(set_root_equal_to_desired_node(x))
    end
    child_output
  end

  def return_score_and_total_child_nodes_plus_root(node_scores_at_a_level, total_children_and_root, percentage_nodes)
    node_scores = node_scores_at_a_level
    total_child = total_children_and_root
    percent = percentage_nodes
    node_scores.zip(total_child, percent)
  end

  def total_number_of_nodes_in_the_tree
    sort.count
  end

  def percentage_of_all_nodes_that_are_this_node_or_its_children(node_scores)
    percent_output = []
    node_scores.map do |val|
      percent_output << ((sort_child_nodes_and_convert_to_total(set_root_equal_to_desired_node(val)).to_f / total_number_of_nodes_in_the_tree.to_f) * 100.00).round(2)
    end
    percent_output
  end

  def health(depth)
    node_scores = return_nodes_at_given_level(depth)
    total_nodes_including_root = find_total_child_nodes_for_each_node_at_a_given_depth(depth)
    percentage_of_total = percentage_of_all_nodes_that_are_this_node_or_its_children(return_nodes_at_given_level(depth))
    return_score_and_total_child_nodes_plus_root(node_scores, total_nodes_including_root, percentage_of_total)
  end

end
