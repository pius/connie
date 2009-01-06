Connie Release 0.0.1 (January 5th 2009) 
===================================

**Git**:  [http://github.com/pius/connie](http://github.com/pius/connie)   
**Author**:    Pius Uzamere, [The Uyiosa Corporation](http://www.uyiosa.com)

**Copyright**: Pius Uzamere © 2009
**License**:  The Lesser GNU Public License


SYNOPSIS
--------

Connie is a Ruby library that implements [SPARQL](http://www.w3.org/TR/rdf-sparql-query/) given a parse tree of a SPARQL query and a set of RDF triples.  Implements SPARQL properties as a set of constraints.  The constraints are executed by [Gecode/R](http://gecoder.rubyforge.org/), a Ruby bridge to Gecode, an open source library for constraint programming written in C.


FEATURE LIST
------------
                                                                              
1. **Connie can handle simple, univariate triple patterns**: When finished, this library will have a full test suite and can serve as a maintainable reference implementation of a SPARQL engine in Ruby.  Currently, only very basic queries are supported.  Please see the spec suite for the latest usage examples or check out the documentation for more details.

USAGE
-----

1. **Make Sure You've Got the Dependencies installed**

Connie depends on Gecode/R (http://gecode.rubyforge.org) and Reddy (http://www.github.com/tommorris/reddy).

  > sudo gem install gecoder-with-gecode

2. **Clone the Repository and Install the Connie Gem from Source**

  > git clone git://github.com/pius/connie.git 
  > cd connie
  > gem build connie.gemspec
  > sudo gem install connie


3. **Require the gem in your code, play with it**

For usage, the best thing is to click through the [documentation](http://pius.github.com/connie).  I tried to make it really thorough.  If you need more guidance, check out the specs, which demonstrate precisely how to feed Connie a SPARQL query parse tree and run the engine.


4. **Contribute!**

Fork my [repository](http://github.com/pius/sparql), make some changes, and send along a pull request!

The best way to contribute is to add a unit test for a specific SPARQL parse tree and then tweak the code such that your new test case plus all the others pass.
                                                                              

COPYRIGHT
---------                                                                 

Connie was created in 2009 by Pius Uzamere (pius -AT- alum -DOT- mit -DOT- edu) and is    
licensed under the LGPL.
