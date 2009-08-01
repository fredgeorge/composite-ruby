module Pattern
  module Test
    
    class Group
      include Pattern::Composite
      recursive_total :salary, :overhead
      recursive_values :name
      recursive_collecting :skills
    end
    
    class Employee
      attr_reader :name, :skills
      def initialize(name, salary, overhead, *skills)
        @name, @salary, @overhead, @skills = name, salary, overhead, skills
      end
      def salary(month_count = 1)
        month_count * @salary
      end
      def overhead(month_count = 1)
        month_count * @overhead
      end
    end
    
  end
end

