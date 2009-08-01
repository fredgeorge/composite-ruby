# :enddoc:

module Pattern
  module Test
    
    class NumberTree
      include Pattern::Composite
      recursive_total :to_i, :to_f, :square
    end
    
  end
end

class Numeric 
  def square
    self * self
  end
end

