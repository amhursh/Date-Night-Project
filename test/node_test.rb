gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'
require_relative '../lib/binary_search_tree'

class TreeTest < Minitest::Test

  def test_that_node_has_score
    node = Node.new(12, "The Hills Have Eyes", 0)
    assert_equal 12, node.score
  end

  def test_that_node_has_title
    node = Node.new(12, "The Hills Have Eyes", 0)
    assert_equal "The Hills Have Eyes", node.title
  end

  def test_that_node_has_depth
    node = Node.new(12, "The Hills Have Eyes", 0)
    assert_equal 0, node.depth
  end

  def test_that_node_has_left_and_right_children_of_nil
    node = Node.new(12, "The Hills Have Eyes", 0)
    assert_nil node.left
    assert_nil node.right
  end

  def test_node_info_is_a_hash_of_title_and_score
    node = Node.new(12, "The Hills Have Eyes", 0)
    assert_equal node.info, {"The Hills Have Eyes" => 12}
  end

end
