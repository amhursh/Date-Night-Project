gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/binary_search_tree'

class TreeTest < Minitest::Test

  def test_that_tree_exists
    bst1 = BinarySearchTree.new
    assert_nil bst1.root
  end

  def test_that_tree_initializes_with_nil_root_node
    bst1 = BinarySearchTree.new
    assert bst1.empty?
  end

  def test_that_insert_returns_depth_of_new_node
    bst1 = BinarySearchTree.new
    assert_equal 0, bst1.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, bst1.insert(16, "Johnny English")
    assert_equal 1, bst1.insert(92, "Sharknado 3")
    assert_equal 2, bst1.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_that_include_verifies_presence_of_a_given_score_in_the_tree
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert bst1.include?(16)
    refute bst1.include?(72)
  end

  def test_depth_of_returns_depth_where_a_score_appears
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 1, bst1.depth_of(92)
    assert_equal 2, bst1.depth_of(50)
  end

  def test_max_returns_highest_score_in_the_tree_as_a_hash
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal bst1.max, {"Sharknado 3"=>92}
    refute_equal bst1.max, {"Johnny English"=>16}
  end

  def test_min_returns_lowest_score_in_tree_as_a_hash
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal bst1.min, {"Johnny English"=>16}
    refute_equal bst1.min, {"Sharknado 3"=>92}
  end

  def test_sort_returns_all_nodes_in_order_and_as_an_array_of_hashes
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal bst1.sort, [{"Johnny English"=>16},
      {"Hannibal Buress: Animal Furnace"=>50},
      {"Bill & Ted's Excellent Adventure"=>61},
      {"Sharknado 3"=>92}]
    refute_equal bst1.sort, [{"Bill & Ted's Excellent Adventure"=>61},
      {"Hannibal Buress: Animal Furnace"=>50},
      {"Johnny English"=>16},
      {"Sharknado 3"=>92}]
  end

  def test_load_returns_the_number_of_files_added
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 95, bst1.load('/Users/Aaron/turing/1module/projects/date_night/lib/movies.txt')
  end

  def test_health_returns_array_of_score_total_nodes_in_current_root_and_percentage
    bst1 = BinarySearchTree.new
    bst1.insert(61, "Bill & Ted's Excellent Adventure")
    bst1.insert(16, "Johnny English")
    bst1.insert(92, "Sharknado 3")
    bst1.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal [[61, 4, 100.0]], bst1.health(0)
    assert_equal [[16, 2, 50.0], [92, 1, 25.0]], bst1.health(1)
    assert_equal [[50, 1, 25.0]], bst1.health(2)
    assert_equal [], bst1.health(3)
  end

end
