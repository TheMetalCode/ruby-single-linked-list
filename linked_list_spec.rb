require 'rspec'
require_relative 'linked_list'

RSpec.describe LinkedList do

  describe '#add' do
    describe 'when empty' do

      let(:list) { LinkedList.new }

      it 'adds a node to the list' do
        list.add('foo')
        expect(list.head.val).to eq('foo')
        expect(list.head.next).to be_nil
      end
    end

    describe 'when not empty' do

      let(:list) { LinkedList.new('foo') }

      it 'adds node to the list' do
        list.add('bar')
        expect(list.head.next.val).to eq('bar')
      end
    end
  end

  describe '#delete' do
    describe 'when empty' do

      let(:list) { LinkedList.new }
      subject { -> { list.delete('foo') } }
      it { is_expected.to raise_error('nothing to remove') }
    end

    describe 'when not empty' do
      it 'deletes a node matching the value' do
        list = LinkedList.new('foo')
        list.add('bar')
        list.delete('foo')
        expect(list.head.val).to eq('bar')
        expect(list.head.next).to be_nil
      end
    end

    describe 'when last one out' do
      let(:list) { LinkedList.new('foo') }
      it 'results in an empty list' do
        list.delete('foo')
        expect(list.head).to be_nil
      end
    end

    describe 'when last one out with size > 1' do
      before do
        @list = LinkedList.new('foo')
        @list.add('bar')
      end
      it 'removes at the end' do
        @list.delete('bar')
        expect(@list.head.val).to eq('foo')
      end
    end


    describe 'when middle one out' do
      before do
        @list = LinkedList.new('foo')
        @list.add('bar')
        @list.add('bacon')
      end

      it 'removes at the end' do
        @list.delete('bar')
        expect(@list.head.val).to eq('foo')
        expect(@list.head.next.val).to eq('bacon')
      end
    end
  end

  describe '#print_list' do
    describe 'when empty' do
      let(:list) { LinkedList.new }

      it 'prints a blank string' do
        expect(list.print).to eq('')
      end
    end

    describe 'when not empty' do
      before do
        @list = LinkedList.new('foo')
        @list.add('bar')
        @list.add('foobar')
      end

      it 'prints an array of the values' do
        expect(@list.print).to eq('foo -> bar -> foobar')
      end
    end
  end

  describe '#uniq' do

    describe 'when empty' do
      subject { -> { LinkedList.new.uniq } }
      it { is_expected.to raise_error('Nothing to dedupe') }
    end

    describe 'when not empty and has dupes' do
      before do
        @list = LinkedList.new('foo')
        @list.add('bar')
        @list.add('foobar')
        @list.add('foo')
      end

      it 'returns a deduped list' do
        @list.uniq
        expect(@list.print).to eq('foo -> bar -> foobar')
      end
    end

    describe 'when not empty and has no dupes' do
      before do
        @list = LinkedList.new('foo')
        @list.add('bar')
        @list.add('foobar')
      end

      it 'returns the same list' do
        @list.uniq
        expect(@list.print).to eq('foo -> bar -> foobar')
      end
    end
  end
end