require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'Unbalanced', Pattern::Composite do
  
  before(:all) do
    accounting = group.new(
        employee.new('Kermit', 1500, 300, 'Leaping', 'Naive'),
        employee.new('Cookie Monster', 2000, 400, 'Eating', 'Mayhem'),
        employee.new('Ernie', 1300, 260, 'Shy', 'Naive') )
    finance = group.new(
        employee.new('Miss Piggy', 5000, 1000, 'Assertive', 'Volatile'),
        accounting)
    @company = group.new(
        employee.new('Ratbert', 100000, 25, 'Greedy', 'Cynical'), 
        finance)
  end
  
  it "can total" do
    @company.salary.should == 109800
    @company.overhead.should == 1985
  end
  
  it "can total with parameters" do
    @company.salary(3).should == 3 * 109800
  end
  
  it "can aggregate leaf responses" do
    @company.name.sort.should == ['Cookie Monster', 'Ernie', 'Kermit', 'Miss Piggy', 'Ratbert']
  end
  
  it "can collect leaf array responses" do
    @company.skills.uniq.sort.should == ['Assertive', 'Cynical', 'Eating', 'Greedy', 'Leaping', 'Mayhem', 'Naive', 'Shy', 'Volatile']
  end
  
  private
  
    def group
      Pattern::Test::Group
    end
    
    def employee
      Pattern::Test::Employee
    end
  
end