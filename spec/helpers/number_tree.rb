module Pattern
  module Test
    
    class NumberTree
      include Pattern::Composite
      recursive_total :to_i, :to_f
    end
    
  end
end

