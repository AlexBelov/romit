require 'spec_helper'
require 'romit/base'

describe Romit::Base do
  HASH = {a: 1, b: 2}
  subject { Romit::Base.new(:member_account, HASH) }

  it 'reload to_hash method' do
    assert_equal subject.to_hash, HASH
  end

  it 'reload [] method' do
    assert_equal subject[:a], HASH[:a]
  end

  it 'reload []= method' do
    subject[:c] = 3
    assert_equal subject[:c], 3
  end

  it 'return hash keys' do
    assert_equal subject.keys, HASH.keys
  end

  it 'return hash values' do
    assert_equal subject.values, HASH.values
  end

  it 'redefines empty? method' do
    assert_equal subject.empty?, false
  end
end
