require 'rubygems'
require 'gecoder'
require 'pp'
require 'reddy'

class Reddy::Literal
  def value
    return contents if self.respond_to?(:contents)
    return to_s
  end
end

class Reddy::URIRef
  def value
    return contents if self.respond_to?(:contents)
    return to_s
  end
end

class Reddy::BNode
  def value
    return contents if self.respond_to?(:contents)
    return to_s
  end
end

class Reddy::Triple
  
  def matches_pattern?(h)
    keys = h.keys
    if keys.include? :subject
      return false unless (subject.value == h[:subject])
    end
    if keys.include? :object
      return false unless (object.value == h[:object])
    end
    if keys.include? :predicate
      return false unless (predicate.value == h[:predicate])
    end
    return true
  end
  
  def to_array
    [subject, predicate, object]
  end
end

module SparqlConstraints
  #you've got triple patterns e.g. ()?x foo:bar baz)
  #return a solution sequence
  
  def self.correspond_to?(val, mapping)
    @@the_mapping ||= mapping
    mapping.index(val)
  end
  
  #term constraints
  def self.term_equals(terms, term_index, putative_term, mapping)
    terms[term_index].must == correspond_to?(putative_term, mapping)
  end
  
  def self.term_must_fit_into(unbound_variables, unbound_term_index, pattern, universe, mapping)
    them = self.terms_with_patterns_that_otherwise_fit(pattern, universe).collect {|term| 
      self.correspond_to?(term.value, mapping) }
    unbound_variables[unbound_term_index].must_be.in them
  end
  
  def self.terms_with_patterns_that_otherwise_fit(pattern, universe)
    mu = universe.select {|triple| triple.matches_pattern?(pattern)}
    unless pattern[:subject]
      return mu.collect {|t| t.subject}
    end
    unless pattern[:object]
      return mu.collect {|t| t.object}
    end
    unless pattern[:predicate]
      return mu.collect {|t| t.predicate}
    end
  end
end


class SparqlQuery
   include Gecode::Mixin
   include SparqlConstraints
   attr_reader :variables_to_solve_for
   attr_reader :element_mapping
   
   def the_property_map(input_triples)
     props = input_triples.collect {|triple|
          triple.to_array
       }.flatten.collect{|e| e.value}.uniq
   end
  
  ## 
  # Instantiates a new query.
  #
  #
  # ==== Returns
  #   a query object that can be solved
  #
  # ==== Example
  # @t1 = Triple.new('foo', 'foaf:knows', 'baz')
  # @t2 = Triple.new('foo', 'foaf:knows', 'bar')
  # 
  # x = SparqlQuery.new({:select => %w(x), 
  #                     :where => [{:unbound => "x", :predicate => "foaf:knows", :subject => "foo"}]},
  #                     [@t1, @t2])
  #
  # @author Pius Uzamere

  def initialize(query_clauses, input_triples)
    @query = query_clauses
    @element_mapping = the_property_map(input_triples)
    @universe = input_triples
    #note that the selected/constructed variables will be a subset of these
    
    n = @element_mapping.size
   
   @variables_to_solve_for = int_var_array(3 * query_clauses[:where].size, 0...n)
   
   @unbound_vars = process_query(@query)
   
   # TODO: learn what heuristic to use here
   branch_on @variables_to_solve_for, :variable => :smallest_size, :value => :min
  end


  ## 
  # Instantiates the constraints based on the parse tree of the query.
  #
  # ==== Side Effects
  #   creates constraints based on the where clauses
  #   determines views on the result based on whether query is SELECT or CONSTRUCT
  #
  # ==== Returns
  #   an array of the unbound vars
  #
  # ==== Example
  #   process_query({:select => %w(x), 
  #                     :where => [{:unbound => "x", :predicate => "foaf:knows", :subject => "foo"}]})
  #   =>  ['x']
  #
  # @author Pius Uzamere
  
  def process_query(query_clauses, unbound_vars = [])
    if query_clauses[:select]
      raise "malformed query parse" unless query_clauses[:select].instance_of?(Array)
      query_clauses[:select].each {|term|
        #SparqlConstraints.term_equals(term, clause[:subject], @element_mapping) if clause[:subject]
      }   
    end
  
    if query_clauses[:construct]
       #CONSTRUCT takes a query pattern and builds an RDF graph based on it
      raise "CONSTRUCT queries not supported yet, sorry."
      c = query_clauses[:construct]
      raise "malformed query parse" unless (c.respond_to?(:subject) & c.respond_to?(:predicate) & c.respond_to?(:object))
    end
  
    if query_clauses[:where]
      raise "malformed query parse: query_clauses[:where] should be an array" unless query_clauses[:where].instance_of?(Array)

      query_clauses[:where].each_with_index {|clause, index|
        raise "malformed query parse: each where clause should have an unbound variable" unless clause[:unbound]
        unbound_vars << clause[:unbound]
        g = SparqlConstraints.term_must_fit_into(@variables_to_solve_for, (unbound_vars.size - 1), clause, @universe, @element_mapping) if clause[:unbound]
        if index == (query_clauses[:where].size - 1)
          @variables_to_solve_for.reverse.slice!(0,(unbound_vars.size)) # CAREFUL.  Doesn't seem to do what I want.
        end
      }
    end
    return unbound_vars
  end

  def vars_from_pattern(pattern)
    unbound_vars = pattern.values.select {|val| val.begins_with? "unbound_"}
    unbound_vars = unbound_vars.map{|val| val.slice(8,val.size)}
  end
  
  def to_s(map = @element_mapping)
    rows = @variables_to_solve_for.values#.collect {|element| map[element]}
  end
  
end