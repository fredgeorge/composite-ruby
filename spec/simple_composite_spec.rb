require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'Simple', Pattern::Composite do
  
  it "can have children" do
    tree = number_tree.new
    tree << 3
    tree.add(6)
    tree.length.should == 2
    tree.size.should == 2
  end
  
  it "can be created with children" do
    tree = number_tree.new 3, 4, 5
    tree.length.should == 3
  end
  
  it "can total attributes of leaves" do
    tree = number_tree.new 3, 4, 5
    tree.total(:to_i).should == 12
  end
  
  it "can reference totals directly by leaf attributes" do
    tree = number_tree.new 3, 4, 5
    tree.to_i.should == 12
    
    tree = number_tree.new 3.5, 1.75, 4.75
    tree.to_i.should == 8
    tree.to_f.should == 10
  end
  
  it "returns int as a total if floats have no fraction" do
    tree = number_tree.new 3.5, 1.75, 4.75
    tree.to_f.should == 10
    tree.to_f.class.should == Fixnum  
  end
  
  private
  
    def number_tree
      Pattern::Test::NumberTree
    end
    
end
