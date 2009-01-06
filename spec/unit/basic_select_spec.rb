# This file is part of Connie
# 
# Connie is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Connie is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with Connie.  If not, see <http://www.gnu.org/licenses/>.

require 'pathname'
require 'reddy'
require 'lib/connie'


require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe "the basic select form" do
  before(:all) do
     @t1 = Triple.new('foo', 'foaf:knows', 'baz')
     @t2 = Triple.new('foo', 'foaf:knows', 'bar')
  end
  
  it "should be able to solve given a single, basic, univariate triple pattern" do
    x = SparqlQuery.new({:select => %w(x), 
                        :where => [{:unbound => "x", :predicate => "foaf:knows", :subject => "foo"}]},
                        [@t1]).solve!
    x.variables_to_solve_for.values.should == [2,0,0]
    x.element_mapping.should == %w(foo foaf:knows baz)
  end
end