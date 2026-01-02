include <Chamfers-for-OpenSCAD/Chamfer.scad>
use <validators/std.scad>
use <attrs/rail.scad>
// $fs = 0.1; $fa = 0.5;

module rail( attrs = rail_attrs(), position = "middle", negative = false ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ "depth", "height", "width" ] )
      validate_gt0(attrs(a), a);
    for( a = [ ] )
      validate_defined(attrs(a), a);
  }

  if( position == "middle" ) {
    chamferCube([ attrs("width"), attrs("depth"), attrs("height") ], chamfers = [ [ 1, 1, 1, 0 ], [ 0, 0, 0, 0, ], [ 0, 0, 0, 0 ] ] );
  } else {
    chamferCube([ attrs("width"), attrs("depth"), attrs("height") ], chamfers = [ [ 1, 0, 0, 0 ], [ 0, 0, 0, 0, ], [ 0, 0, 0, 0 ] ] );
  }

}

rail();