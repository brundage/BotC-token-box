/*
  Searches an "associative vector" of [ key, value ] vectors for key and
  returns the value or runs value()
  [
    [ key, value ],
    [ key, value ],
    ...
  ]
*/
function g(key, dict) =
  let( value = dict[search([key], dict)[0]][1] )
    is_function(value) ? value() : value;
    // $strict ? assert(value != undef) : ( is_function(value) ? value() : value );


name = "name";
value = "value";
subject = [ [ name, value ] ] ;
subject_f = [ [ name, function() value ] ];
assert(g(name, subject) == value);
assert(g(name, subject_f) == value );


/*
  takes a vector of [ key, value ] vectors
  returns a lookup function for that vector
*/
function o(dict) =
  function(attr=undef)
    attr == undef ? function(attr) f(attr) : g(attr, dict);
