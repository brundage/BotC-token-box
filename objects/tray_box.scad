include <Chamfers-for-OpenSCAD/Chamfer.scad>
use <validators/std.scad>
use <attrs/tray_box.scad>
use <objects/token_tray.scad>
use <objects/wall.scad>
use <attrs/wall.scad>
use <objects/token_tray.scad>
// $fs = 0.1; $fa = 0.5;

module tray_box( attrs = tray_box_attrs(), negative = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ "tray tolerance", "width", "depth", "bottom thickness", "trays" ] )
      validate_gt0(attrs(a), a);
    for( a = [ ] )
      validate_defined(attrs(a), a);
  }


  module bottom() {
    ch = [ [ 1, 1, 0, 0 ], [ 1, 0, 0, 1 ], [ 1, 1, 1, 1 ] ];
    chamferCube( [ attrs("width"), attrs("depth"), attrs("bottom thickness") ], chamfers = ch );
  }

  bottom();
  translate([ 0, 0, attrs("bottom thickness") ]) {
    wall();
    % translate([ wall_attrs("wall thickness"), 0, 0 ]) token_tray(onepiece = true);
  }
}

tray_box();