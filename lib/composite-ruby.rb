$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module CompositeRuby
  VERSION = '0.0.1'
end

module Pattern
  module Composite
    include Enumerable
    
    def initialize(*children)
      composite_initialize(*children)
    end
  
    def composite_initialize(*children)
      @children = children
    end
  
    def <<(child)
      @children ||= []
      @children << child
    end

    alias :add :'<<'
    
    def length
      @children.length
    end
    
    alias :size :length

    def each
      @children.each { |child| yield child }
    end

    def total(accessor, *params)
      result = self.inject(0.0) { |total, child| total + child.send(accessor, *params) }
      result.round == result ? result.to_i : result
    end
  
    def aggregate(accessor, *params)
      self.inject([]) { |all, child| all << child.send(accessor, *params) }.flatten || []
    end
  
    def collecting(accessor, *params)
      self.inject([]) { |all, child| all + child.send(accessor, *params) } || []
    end
  
    def self.append_features(mod)
      def mod.recursive_total(*accessors)
        accessors.each do |accessor|
          self.send(:define_method, accessor, lambda { |*params| total(accessor, *params) } )
        end
      end    
      def mod.recursive_values(*accessors)
        accessors.each do |accessor|
          self.send(:define_method, accessor, lambda { |*params| aggregate(accessor, *params) } )
        end
      end    
      def mod.recursive_collecting(*accessors)    # Collecting parameter [Beck]
        accessors.each do |accessor|
          self.send(:define_method, accessor, lambda { |*params| collecting(accessor, *params) } )
        end
      end    
      super
    end

  end
end