include <Chamfers-for-OpenSCAD/Chamfer.scad>
use <validators/std.scad>
use <attrs/token_tray.scad>
use <objects/token_caddy.scad>
use   <attrs/token_caddy.scad>
use   <attrs/rail.scad>
$fs = 0.1; $fa = 0.5;

module token_tray( attrs = token_tray_attrs(), negative = false, onepiece = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    validate_defined(token_caddy_attrs(), "token caddy attrs");
    for( a = [ "caddy tolerance", "height", "width", "depth", "rows", "cols", "bottom thickness" ] )
      validate_gt0(attrs(a), a);
    for( a = [ ] )
      validate_defined(attrs(a), a);
  }


  module caddy() {
    x_step = token_caddy_attrs("width") - token_caddy_attrs("wall thickness") / 2;
    y_step = token_caddy_attrs("depth") - token_caddy_attrs("wall thickness") / 2;
    for( i = [0:attrs("cols")-1] ) {
      for( j = [0:attrs("rows")-1] ) {
        translate([ i * x_step, j * y_step, 0 ]) token_caddy();
      }
    }
  }


  module drawer_bottom() {
    ch_h = 0.5 * attrs("bottom thickness");
    c = [ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ];
    w = 2 * attrs("caddy tolerance") + attrs("cols") * (token_caddy_attrs("width") - token_caddy_attrs("wall thickness") / 2) + token_caddy_attrs("wall thickness") / 2;
    d = attrs("rows") * (token_caddy_attrs("depth") - token_caddy_attrs("wall thickness") / 2) + token_caddy_attrs("wall thickness") / 2;
    h = attrs("bottom thickness");
    translate([ rail_attrs("width"), 0, 0 ]) chamferCube([ w, d, h ], ch = ch_h, chamfers = c );
    rail();
    translate([ w + rail_attrs("width"), 0, 0 ]) rail();
  }


  module on_bottom() {
    translate([ rail_attrs("width"), 0, attrs("bottom thickness") ]) children();
  }


  module rail() {
    d = attrs("rows") * (token_caddy_attrs("depth") - token_caddy_attrs("wall thickness") / 2) + token_caddy_attrs("wall thickness") / 2;
    chamferCube([ rail_attrs("width"),d, rail_attrs("height") ], chamfers = [ [ 1, 1, 1, 0 ], [ 0, 0, 0, 0, ], [ 0, 0, 0, 0 ] ] );
  }


  if( onepiece ) {
    drawer_bottom();
    on_bottom() translate([ attrs("caddy tolerance"), 0, 0 ]) caddy();
  } else {
    caddy();
    translate([ attrs("width") + 20, 0, 0 ]) {
      drawer_bottom();
      % on_bottom() caddy();
    }
  }
  // % translate([ 0, 0, -5 ]) square([ 215.9, 279.4 ]);
}

token_tray( onepiece = false );