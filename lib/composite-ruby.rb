$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module CompositeRuby    #:nodoc:
  VERSION = '0.0.2'
end

module Pattern    #:nodoc:
  
  # :include: ../README.rdoc
  #
  # =Class Pattern::Composite
  # A Mix-in to add Composite Pattern [GoF] behavior to a class.  In a Composite Pattern,
  # an Object of some type holds Objects of similar type, with the parent and the children
  # supporting (nearly) the same methods.  That is, a question or action on the parent is a 
  # reasonable question or action on a child.  Children could be another instance of the
  # Composite, or could be a leaf (an Object with no possible children of its own).
  #
  # The Composite Pattern is useful for anything with a hierarchical or tree structure, such 
  # as organizations, drilling down into accounting details, and the like.
  #
  # Classes mixing Composite can use shorthand notations to create methods that total 
  # (Composite#total), methods that aggregate an Array of leaf answers (Composite#aggregate),
  # and methods that collect a flattend Array of leaf Array answers (Composite#collecting), 
  # a form inspired by _attr_reader_.
  module Composite
    include Enumerable
    
    # Create a new instance of the Composite class, with optional children.
    def initialize(*children)
      composite_initialize(*children)
    end
  
    # Helper method that actually initializes the children; this method is 
    # useful for classes that use their own initializers.
    def composite_initialize(*children)
      @children = children
    end
  
    # Add a child to the Composite
    def <<(child)
      @children ||= []
      @children << child
    end

    alias :add :<<
    
    # Return the number of children for this parent Composite
    def length
      @children.length
    end
    
    alias :size :length

    # Iterate across each child of the Composite.  This method, in concert with including
    # Enumerable, gives the Composite a full set of iterators.
    def each
      @children.each { |child| yield child }
    end

    # Sum the values from each leaf for the given Numeric attribute or method.  Optionally,
    # parameters may be passed to each leaf.
    #
    # The helper notation _recursive_total_ will generate custom total methods:
    #   class MyClass
    #     include Pattern::Composite
    #     recursive_total :var
    #     ...
    #   end
    # generates a _var_ method that returns the total of leaf answers to _var_ that can
    # be invoked directly by:
    #   my_class.var
    def total(accessor, *params)
      result = self.inject(0.0) { |total, child| total + child.send(accessor, *params) }
      result.round == result ? result.to_i : result
    end
  
    # Return a Array of the values that each leaf returns for the given attribute or method.
    # Optionally, parameters may be passed to each leaf.
    #
    # The helper notation _recursive_values_ will generate custom value aggregation methods:
    #   class MyClass
    #     include Pattern::Composite
    #     recursive_values :var
    #     ...
    #   end
    # generates a _var_ method that returns an Array of leaf answers to _var_ that can
    # be invoked directly by:
    #   my_class.var
    def aggregate(accessor, *params)
      self.inject([]) { |all, child| all << child.send(accessor, *params) }.flatten || []
    end
      
    # Return a flattened Array of each Array that each leaf returns for the given attribute 
    # or method.  Optionally, parameters may be passed to each leaf.
    #
    # The helper notation _recursive_collecting_ will generate custom methods that return
    # a flattened Array built from the Arrays returned by each leaf.
    #   class MyClass
    #     include Pattern::Composite
    #     recursive_collecting :var
    #     ...
    #   end
    # generates a _var_ method that returns an Array of leaf answers to _var_ that can
    # be invoked directly by:
    #   my_class.var
    def collecting(accessor, *params)
      self.inject([]) { |all, child| all + child.send(accessor, *params) } || []
    end
  
    # Callback method that creates the three class-level directives -- :recursive_total,
    # :recursive_values, and :recursive_collecting
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