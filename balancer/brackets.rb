require 'minitest/autorun'

class BracketsChecker
  def initialize(brackets)
    @brackets = brackets.split('')
  end

  def balanced?
    counter = {
      round_brackets: 0,
      box_brackets: 0,
      curly_brackets: 0
    }
    @brackets.each do |bracket|
      case bracket
      when '('
        counter[:round_brackets] += 1
      when ')'
        counter[:round_brackets] -= 1
      when '['
        return false if counter[:round_brackets] != 0
        counter[:box_brackets] += 1
      when ']'
        return false if counter[:round_brackets] != 0
        counter[:box_brackets] -= 1
      when '{'
        return false if counter[:box_brackets] != 0
        return false if counter[:round_brackets] != 0
        counter[:curly_brackets] += 1
      when '}'
        return false if counter[:round_brackets] != 0
        return false if counter[:box_brackets] != 0
        counter[:curly_brackets] -= 1
      else
        return false
      end
      return false if counter.any? { |key, val| val < 0 }
    end
    counter.values.all? { |val| val == 0 }
  end
end


describe BracketsChecker do
  it 'should mark the brackets as balanced' do
    bc = BracketsChecker.new('()')
    bc.balanced?.must_equal true
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new(')(')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as balanced' do
    bc = BracketsChecker.new('[()]')
    bc.balanced?.must_equal true
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new(']()]')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('([])')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('[()(])')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as balanced' do
    bc = BracketsChecker.new('{[()]}')
    bc.balanced?.must_equal true
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('[{()}]')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('({})')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('{(})')
    bc.balanced?.must_equal false
  end

  it 'should mark the brackets as unbalanced' do
    bc = BracketsChecker.new('{[}]')
    bc.balanced?.must_equal false
  end
end
