use <validators/std.scad>
use <attrs/token_caddy.scad>
use <attrs/token.scad>
use <objects/token.scad>

module token_caddy( attrs = token_caddy_attrs(), character_tokens = 3, reminder_tokens = 3, negative = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ "width", "depth", "font size", "wall thickness" ] )
      validate_gt0(attrs(a), a);
  }


  module character_token_stack() {
    scale([ 1, 1, character_tokens ]) token(attrs = character_token_attrs() );
  }


  module corner_cut() {
    trim_d = reminder_token_attrs("diameter") / 8;
    c1_pos = [ trim_d / 2 + attrs("wall thickness"), trim_d / 1.5 + attrs("wall thickness"), 0 ];
    c2_pos = [ c1_pos.x, 6 * c1_pos.y, 0 ];
    c3_pos = [ 6 * c1_pos.x, c1_pos.y, 0 ];
    linear_extrude(height) {
      hull() {
        translate(c1_pos) circle( d = trim_d );
        translate(c2_pos) circle( d = trim_d );
        translate(c3_pos) circle( d = trim_d );
      }
      translate([attrs("width") - attrs("wall thickness")/2, attrs("depth") - attrs("wall thickness")/2, 0]) mirror([ 1, 1, 0 ]) hull() {
        translate(c1_pos) circle( d = trim_d );
        translate(c2_pos) circle( d = trim_d );
        translate(c3_pos) circle( d = trim_d );
      }
    }
  }


  module reminder_token() {
    token( attrs = reminder_token_attrs() );
  }


  module reminder_token_stack() {
    c1_pos = [ attrs("width") - 2 * attrs("wall thickness") - reminder_token_attrs("diameter") / 2,
               reminder_token_attrs("diameter") / 2 + 2 * attrs("wall thickness"),
               0
             ];
    c2_pos = [ attrs("width") / 2, attrs("width") / 2, 0 ];
    c3_pos = [ c1_pos.y, c1_pos.x, 0 ];

    translate(c1_pos) scale([ 1, 1, reminder_tokens ]) {
      reminder_token();
    }
    translate(c2_pos) scale([ 1, 1, reminder_tokens ]) reminder_token();
    translate(c3_pos) scale([ 1, 1, reminder_tokens ]) {
      reminder_token();
    }
  }


  bottom_thickness = reminder_tokens * reminder_token_attrs("thickness");
  height = bottom_thickness +
           character_tokens * character_token_attrs("thickness") +
           attrs("wall thickness") / 4;

  difference() {
    cube([ attrs("width"), attrs("depth"), height ]);
    // hollow it out
    translate([ attrs("wall thickness") / 2, attrs("wall thickness") / 2, bottom_thickness ]) cube([ attrs("width") - attrs("wall thickness"), attrs("depth") - attrs("wall thickness"), height]);
    // cut the corners
    corner_cut();
    // cut out reminder tokens
    reminder_token_stack();
  }
  translate([ attrs("width") / 2, attrs("width") / 2, bottom_thickness ]) {
    % character_token_stack();
  }
}

token_caddy();