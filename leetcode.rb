require 'byebug'

def reverse_vowels(str)
  # T(n)
  # S(2n)
  str = str.split('')
  vowels_index = [];
  vowels = []
  str.each_with_index do |letter,idx|
    if letter =~ /[aeiouAEIOU]/
      vowels_index << idx
      vowels << letter
    end
  end

  vowels = vowels.reverse
  vowels_index.each_with_index do |vowel_index,idx|
    str[vowel_index] = vowels[idx]
  end
  str.join('')
end


def reverse(str)
  # T(n/2)
  # S(1)

  str = str.split('')
  reverse_idx = str.length - 1

  (str.length / 2 ).times do |idx|
    str[idx], str[reverse_idx] = str[reverse_idx], str[idx]
    reverse_idx -= 1
  end
  str.join('')
end

# def is_power_of_four(num)
#   if num % 4 == 0 && ((num / 4) % 4 === 0)
#     return true
#   end
#   return false
# end
#
# p 48 * 48 % 4
# p is_power_of_four(48)


def can_win_nim(n)
  # T(1)
  # S(1)
    return n % 4 != 0;
end


def add_digits_iterative(num)
  while num.to_s.length > 1
    num = num.to_s.split('').map(&:to_i).reduce(&:+)
  end
  num
end

def add_digits_recursion(num)
  return num if num.to_s.length == 1
  add_digits(num.to_s.split('').map(&:to_i).reduce(&:+))
end

class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

def max_depth(root)
    if root.nil?
        return 0
    else
        l_depth = max_depth(root.left)
        r_depth = max_depth(root.right)

        if l_depth > r_depth
            return l_depth+1
        else
            return r_depth+1
        end
    end
end

def merge_two_lists(l1, l2)
    return l2 if l1.nil?
    return l1 if l2.nil?


    if l1.val < l2.val
        l1.next = merge_two_lists(l1.next,l2)
        return l1
    else
        l2.next = merge_two_lists(l1,l2.next)
        return l2
    end


end

def is_same_tree(a, b)
    if a.nil? && b.nil?
        return true
    end
    if a != nil && b != nil
        return a.val == b.val && is_same_tree(a.left, b.left) && is_same_tree(a.right, b.right)
    end

    false
end

def move_zeroes(nums)
    zeroes = nums.count(0)
    nums.delete(0)
    zeroes.times do
        nums << 0
    end
end

def delete_node(node)
    node.val = node.next.val
    node.next = node.next.next
end

def is_anagram(s, t)
    return true if s == t
    return false if s.length != t.length
    t = t.split('').sort
    s.chars.sort.each_with_index do |letter, idx|
        if letter != t[idx]
            return false
        end
    end
    true
end

def title_to_number(s) #perfect, better than 96% of solutions

    alpha = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

    idx = 0
    count = 0
    s = s.reverse
    while idx < s.length
        count += ((alpha.index(s[idx]) + 1) * 26**idx)
        idx += 1
    end
    count

end

def majority_element(nums)
    uniques = nums.uniq
    uniques.each do |num|
        return num if nums.count(num) > nums.length/2
    end

end

def contains_duplicate(nums) # 77%
    nums = nums.sort

    nums.each_index do |idx|
       return true if nums[idx] == nums[idx+1]
    end
    false
end

def reverse_list(head)
    stack = []
    until head.nil?
        stack << head
        head = head.next
    end
    head = stack.pop
    runner = head
    until runner.nil?
        runner.next = stack.pop
        runner = runner.next
    end
    head
end

def hamming_weight(n) # 46%
    index = 0
    binary = []
    while 2**index <= n
        binary << ((n / (2**index)) % 2)
        index += 1
    end

    binary.count(1)
end

def delete_duplicates(head) # 52%
    return head if head.nil?
    checked_nodes = Hash.new(false)
    new_head = ListNode.new(head.val)
    runner = new_head
    head = head.next
    checked_nodes[new_head.val] = true
    loop do
        break if head.nil?
        if checked_nodes[head.val] == false
            checked_nodes[head.val] = true
            runner.next = ListNode.new(head.val)
            runner = runner.next

        end
        head = head.next
    end
    new_head
end

def is_power_of_three(n)
    return false if n < 0
    (Math.log10(n) / Math.log10(3)) % 1 == 0
end

def is_power_of_two(n) # 90%
    return false if n <= 0
    # (Math.log10(n) / Math.log10(2)) % 1 == 0
    until n < 2
        return false if n.odd?
        n = n/2
    end
    true

end

def is_happy(n) # 36%
    combos = []
    nums = n
    loop do
        count = 0
        nums = nums.to_s.split('').map(&:to_i)
        nums.each do |num|
            count += num**2
        end
        return true if count == 1
        return false if combos.include?(count)
        combos << count
        nums = count
    end
end


def rob(nums)
    return 0 if nums.empty?
    even = 0
    odd = 0

    nums.each_with_index do |num,idx|
      debugger
        if idx.even?
            even += num
            even = even > odd ? even : odd
            # this checks when it gets to the second even number, if the previous odd is greater than the
            # two even numbers added, might as well make to current highest count the odd number and
            # continue from here. They won't be next to each other because the current highest count is the
            # previous odd number. The next number is odd and can still be tallied on top.
        else
            odd += num
            odd = even > odd ? even : odd
        end
    end

	return even > odd ? even : odd;

end

class Queue
    # Initialize your data structure here.
    def initialize
        @queue = []
    end

    # @param {Integer} x
    # @return {void}
    def push(x)
        @queue << x
    end

    # @return {void}
    def pop
        @queue.shift
    end

    # @return {Integer}
    def peek
        @queue[0]
    end

    # @return {Boolean}
    def empty
        @queue.length == 0 ? true : false
    end
end

def plus_one(digits)
    digits[-1] += 1

    idx = digits.length-1
    while idx >= 0
       if digits[idx] == 10
         digits[idx] = 0
         if idx == 0
           digits.unshift(1)
           idx = digits.length - 1
         else
           digits[idx-1] += 1
         end
       end
       idx -= 1
    end
    digits
end

def remove_duplicates(nums) # 12%
    # return nums.length if nums.length < 2
    # idx = 1
    # while idx < nums.length
    #     if nums[idx] == nums[idx-1]
    #       nums.delete_at(idx)
    #     else
    #      idx += 1
    #     end
    # end
    # nums.length
    nums.map!(&:to_s).uniq!
    nums.map!(&:to_i).length
end

def max_profit(prices)
    profits = 0
    min = prices[0]
    idx = 1
    while idx < prices.length
        profits = [profits,prices[idx] - min].max
        min = [min,prices[idx]].min
        idx += 1
    end
    profits
end

def two_sum(nums, target)
    hash = {}
    nums.each_index do |idx|
        difference = target - nums[idx]
        if hash[difference] && idx != hash[difference]
            return [hash[difference],idx]
        end
        hash[nums[idx]] = idx
    end
end


def generate(num_rows)
    pascals= []
    num_rows.times do |idx|
        if idx == 0
            pascals << [1]
        else
            pascals << get_row(pascals[-1],idx+1)
        end
    end
    pascals
end

def get_row(prev_row, idx)
    new_row = []
    idx.times do |num|
        if num == 0
            new_row << 1
        elsif num == idx-1
            new_row << 1
        else
            new_row << prev_row[num-1] + prev_row[num]
        end
    end
    new_row
end

def is_palindrome(x) # without extra memory is craziness

    return false if x < 0
    idx2 = x.to_s.length-1
    x.to_s.chars.each_with_index do |num,idx|
        return true if idx2 <= idx
        return false if num.to_i != x.to_s[idx2].to_i
        idx += 1
        idx2 -= 1
    end

end
