require 'pry'
require_relative 'node'

class LinkedList
  attr_accessor :head

  def initialize(val = nil)
    @head = Node.new(val, nil) unless val.nil?
  end

  def add(val)
    # populate @head if list is empty
    if @head.nil?
      @head = Node.new(val, nil)
    else
      current = @head
      # add new node to the end of the line
      current = current.next until current.next.nil?
      current.next = Node.new(val, nil)
    end
  end

  def delete(val)
    # get out fast if list is empty
    raise 'nothing to remove' if @head.nil?
    # starting with head, check the value
    current = @head
    if current.val == val
      # if the desired value to delete is at the head, move the head to the next node
      @head = current.next
    else
      # otherwise, keep evaluating as long as there is a next node and that node's value isn't the
      # one we want to delete
      current = current.next while !current.next.nil? && current.next.val != val
      # once the above finds a hit, set the next node to the 2nd one down the line
      current.next = current.next.next unless current.next.nil?
    end
  end

  def print
    # get out fast if list is empty
    return '' if @head.nil?
    values_to_string
  end

  # a follow-up question one might get
  def uniq
    # get out fast if list is empty
    raise 'Nothing to dedupe' if @head.nil?
    # get array of values
    values = values_to_array
    # now that we have an array of values, use ruby magic to remove dupes
    values.uniq!
    # now build a new list with the de-duped values
    @head = nil
    values.each { |v| add(v) }
  end

  private

  def values_to_string
    elements = ''
    current = @head
    until current.next.nil?
      # append the value of the current node into elements, with an arrow
      elements += "#{current.val} -> "
      current = current.next
    end
    # we're at the last non-nil node now, so just append the value of current node
    elements += current.val
    elements
  end

  def values_to_array
    values = []
    current = @head
    until current.next.nil?
      values << current.val
      current = current.next
    end
    values << current.val
    values
  end
end
