# module Attribute is intended to make getter, setter and tester to resources
# Syntax:
#   attribute a:                  # this makes @a instance variable also as .a
#                                 # .a= and .a? methods
#   attribute a: 5                # additionaly sets @ to default value - 5
#   attribute :a { some_method }  # provides default value as block
#
class Module
  def attribute(sym, &block)

    sym, default = sym.is_a?(Hash) ? [sym.keys[0], sym.values[0]] : [sym, nil]

    define_method "#{sym}=", ->(val) { instance_variable_set "@#{sym}", val }

    define_method "#{sym}" do
      unless instance_variable_defined? "@#{sym}"
        default = instance_eval(&block) if block
        instance_variable_set "@#{sym}", default
      end
      instance_variable_get "@#{sym}"
    end
    
    define_method "#{sym}?", -> { send(sym) ? true : false }
  end
end
