module validate_defined(value, name) {
  assert( value != undef, str(name, " is undefined") );  
}


module validate_gt0( value, name ) {
  n = name == undef ? "" : str(name, " ");
  assert( value >0,  str(n, "(", value, ") is not greater than zero.") );
}


module validate_gte0( value, name ) {
  n = name == undef ? "" : str(name, " ");
  assert( value >=0,  str(n, "(", value, ") is less than zero.") );
}