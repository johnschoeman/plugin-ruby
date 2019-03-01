# frozen_string_literal: true

# rubocop:disable Lint/UnusedBlockArgument
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/LineLength
# rubocop:disable Layout/ExtraSpacing

class BlockTest < Minitest::Text
  def test_inline_block
    a = 0
    test_method { a = 1 }

    assert_equal a, 1
  end

  def test_multiline_block
    a = 0
    test_method do
      a = 1
    end

    assert_equal a, 1
  end

  def test_block_with_only_comment
    result = test_method 'foo' do
      # foobar
    end
    assert_equal result, 'foo'
  end

  def test_block_with_parameters_and_inline_syntax
    a = [1, 2, 3]
    result = a.map { |el| el * 2 }
    assert_equal result, [2, 4, 6]
  end

  def test_block_with_parameters_and_do_end_syntax
    a = [1, 2, 3]
    result = a.map do |el|
      el * 2
    end
    assert_equal result, [2, 4, 6]
  end

  def test_block_with_parameter_and_no_block_content
    a = [1, 2, 3]
    result = a.map { |*| }
    assert_equal result, [nil, nil, nil]
  end

  def test_block_with_parameters_four
    arr = [[1, 2], [3, 4]]
    result = arr.map { |(a, b)| a + b }
    assert_equal result, [3, 7]
  end

  def test_block_with_parameters_five
    arr = [[1, [2, 3], 4, 5, 6, 7]]
    result = arr.map { |a, (b, c), d, *e| "#{a}, #{b}, #{c}, #{d}, #{e}" }
    assert_equal result, ['1, 2, 3, 4, [5, 6, 7]']
  end

  def test_block_with_method_call_one
    arr = ['a', :b, 3]
    result = arr.map { |i| i.to_s }
    assert_equal result, %w[a b 3]
  end

  def test_block_with_method_call_two
    arr = [[1, 2], [3, 4]]
    result = arr.map { |i, j| i.to_s }
    assert_equal result, [%w[1 2], %w[a b]]
  end

  loop { |i| 1 }

  def test_block_with_only_parameter
    result = test_method { |i| }
    assert_equal result, ''
  end

  def test_block_with_method_call_three
    arr = ['a', :b, 3]
    result = arr.map do |i|
      i.to_s
    end
    assert_equal result, %w[a b 3]
  end

  def test_block_with_method_call_four
    arr = [1, 2, 3]
    result = arr.map do |i|
      i.to_s
      i.next
    end
    assert_equal result, %w[a b c]
  end

  def test_blocks_with_parameters_and_long_contents_one
    super_super_super_super_super_super_super_super_super_super_super_super_long = 'foo'
    result = test_method { |x| super_super_super_super_super_super_super_super_super_super_super_super_long }

    assert_equal result, 'foo'
  end

  def test_blocks_with_paramters_and_long_contents_two
    super_super_super_super_super_super_super_super_super_super_super_long = 'foo'
    blk = proc do |i|
      super_super_super_super_super_super_super_super_super_super_super_long
    end

    result = blk.call

    assert_equal result, 'foo'
  end

  def test_block_for_method
    test_method 'foobar' do
    end

    test_method 'foobar' do
      foobar
    end

    assert_equal true, true
  end

  def test_block_for_object
    te.st 'foobar' do
    end

    te.st 'foobar' do
      foobar
    end

    assert_equal true, true
  end

  def test_block_that_makes_a_call_to_the_parameter
    test 'foobar' do |bar|
      bar.to_s
    end

    te.st 'foobar' do |bar|
      bar.to_s
    end

    assert_equal true, true
  end

  def test_block_with_symbol_proc
    test_method(&:to_s)

    assert_equal true, true
  end

  def test_blocks_with_long_contents
    loop { super_super_super_super_super_super_super_super_super_super_super_super_long }

    loop do
      super_super_super_super_super_super_super_super_super_super_super_long
    end

    assert_equal true, true
  end

  def test_block_for_port
    port ENV.fetch('PORT') { 3000 }
  end

  def test_really_long_method_and_parameter
    define_method :long_method_name_that_forces_overflow do |_some_long_argument_that_overflows = Time.now, _other_arg = nil|
    end

    assert_equal true, true
  end

  def test_block_for_loop
    arr = []

    for i in [1, 2, 3] do
      arr << i
    end

    assert_equal arr, [1, 2, 3]
  end

  # rubocop:disable Lint/NestedMethodDefinition
  def test_block_in_method_definition
    def change
      test_method :foo do
        column :bar
      end
    end

    assert_equal true, true
  end
  # rubocop:enable Lint/NestedMethodDefinition

  def test_foo_block
    test_method 'foo' do |bar|
      bar.to_s
    end

    assert_equal true, true
  end

  def test_complicated_method_with_block
    target.method object.map do |arg|
      arg * 2
    end

    assert_equal true, true
  end

  # from ruby test/ruby/test_call.rb
  def test_call_block
    assert_nil(('a'.sub! 'b' do end&.foo {}))
  end

  private

  def test_method(arg = '')
    yield arg
  end
end

# rubocop:enable Layout/ExtraSpacing
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/ClassLength
# rubocop:enable Lint/UnusedBlockArgument
