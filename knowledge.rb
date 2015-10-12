# module Attribute is intended to make getter, setter and tester to resources
# Syntax:
#   attribute a:                  # this makes @a instance variable also as .a
#                                 # .a= and .a? methods
#   attribute a: 5                # additionaly sets @ to default value - 5
#   attribute :a { some_method }  # provides default value as block
#
module Attributes
  def init(sym, block)
    default = nil
    if sym.is_a? Hash
      default = sym.values.first
      sym = sym.keys.first
    end

    define_method "#{sym}=" do |val|
      instance_variable_set "@#{sym}", val
    end

    define_method "#{sym}" do
      unless instance_variable_defined? "@#{sym}"
        default = instance_eval(&block) if block.class == Proc
        instance_variable_set "@#{sym}", default
      end
      instance_variable_get "@#{sym}"
    end

    define_method "#{sym}?" do
      send(sym) ? true : false
    end
  end
end

# :nodoc
class Module
  def attribute(sym, &block)
    extend Attributes
    init(sym, block)
  end
end
