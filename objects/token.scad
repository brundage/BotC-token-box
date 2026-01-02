use <validators/std.scad>
use <attrs/token.scad>

module token( attrs = character_token_attrs(), negative = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ "diameter", "thickness" ] )
      validate_defined(attrs(a), a);
  }

  cylinder( h = attrs("thickness"), d = attrs("diameter") );

}

token();

translate([ character_token_attrs("diameter")/2 + reminder_token_attrs("diameter"), 0, 0 ]) token(attrs = reminder_token_attrs() );