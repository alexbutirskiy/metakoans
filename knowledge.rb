require 'byebug'

module Attributes

  def init sym
    puts "Self is #{self} class=#{self.class}"

    define_method "#{sym}=" do |val|
      #puts "It's a setter. Sym = #{sym}"
      instance_variable_set "@#{sym}", val
    end

    define_method "#{sym}" do
      unless instance_variable_defined? "@#{sym}"
        instance_variable_set "@#{sym}", nil
      end
      #puts "It's a getter. Sym = #{sym}"
      instance_variable_get "@#{sym}"
    end

    define_method "#{sym}?" do
      #puts "It's a tester. Sym = #{sym}"
      self.send(sym) ? true : false
    end

  end
end

class Module
  def attribute sym
    extend Attributes
    init sym
  end
end










# class C
#   attribute :o
#   class << self
#     attribute :c
#   end
# end

# # C.test
# # C.new.test

# o = C.new

# puts C.c
# puts o.o

# puts C.c?
# puts o.o?

# C.c = 1
# o.o = 2

# puts C.c
# puts o.o

# p C
# p C.new

# puts C.c?
# puts o.o?
