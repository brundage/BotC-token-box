use <validators/std.scad>
use <attrs/REPLACE.scad>

module REPLACE( attrs = REPLACE_attrs(), negative = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ ] )
      validate_gt0(attrs(a), a);
    for( a = [ ] )
      validate_defined(attrs(a), a);
  }


}

REPLACE();