include <Chamfers-for-OpenSCAD/Chamfer.scad>
use <validators/std.scad>
use <attrs/wall.scad>
use <attrs/token_tray.scad>
use <attrs/tray_box.scad>
use <attrs/rail.scad>
// $fs = 0.1; $fa = 0.5;

module wall( attrs = wall_attrs(), negative = false, left = true ) {
  validate();

  module validate() {
    validate_defined(attrs, "attrs");
    for( a = [ "depth", "height", "wall thickness" ] )
      validate_gt0(attrs(a), a);
    for( a = [ ] )
      validate_defined(attrs(a), a);
  }


  // module bottom_wall_segment() {
  //   outer_wall( c = [ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 1 ] ] );
  //   translate([ attrs("wall thickness"), 0, 0 ]) rail(position = "bottom");
  // }


  // module middle_wall_segment() {
  //   outer_wall();
  // }


  // module top_wall_segment() {
  //   outer_wall();
  // }


  // module outer_wall( c = [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0, ], [ 1, 0, 0, 1 ] ] ) {
  //   chamferCube([ attrs("wall thickness"), attrs("depth"), attrs("height") ], chamfers = c );
  // }


  module rail( position = "middle" ) {
    if( position == "top") chamferCube([ rail_attrs("width"), attrs("depth"), rail_attrs("height") ], chamfers = [ [ 1, 0, 0, 1 ], [ 0, 0, 0, 0, ], [ 0, 0, 0, 0 ] ] );
    if( position == "middle" ) chamferCube([ rail_attrs("width"), attrs("depth"), rail_attrs("height") ], chamfers = [ [ 1, 0, 0, 1 ], [ 0, 0, 0, 0, ], [ 0, 0, 0, 0 ] ] );
    if( position == "bottom") chamferCube([ rail_attrs("width"), attrs("depth"), rail_attrs("height") ], chamfers = [ [ 1, 1, 0, 1 ], [ 0, 0, 1, 0, ], [ 0, 0, 0, 0 ] ] );
  }


  module wall_segment( position ) {
    rail_dimensions = [ rail_attrs("width"),     attrs("depth"), attrs("height") - rail_attrs("height") ];
    wall_dimensions = [ attrs("wall thickness"), attrs("depth"), attrs("height") ];
    rail_translation = [ attrs("wall thickness"), 0, rail_attrs("height") ];

    chamferCube(wall_dimensions, chamfers = [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 1 ] ] );
    if( position == "top" ) {
      translate(rail_translation)
        chamferCube(rail_dimensions, chamfers = [ [ 1, 0, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ] ] );

    } else if( position == "middle" ) {
      translate(rail_translation)
        chamferCube(rail_dimensions, chamfers = [ [ 1, 0, 0, 1 ], [ 0, 0, 1, 0, ], [ 0, 0, 0, 0 ] ] );

    } else if( position == "bottom") {
      translate(rail_translation)
        chamferCube(rail_dimensions, chamfers = [ [ 1, 0, 0, 1 ], [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ] ] );

    } else { 
      echo("Bad position: ", position);
    }
  }


  module wall_stack() {
    wall_segment("bottom");
    for( i = [1:tray_box_attrs("trays") - 2] ) {
      translate([ 0, 0, i * attrs("height") ]) wall_segment("middle");
    }
    translate([ 0, 0, ( tray_box_attrs("trays") - 1 ) * attrs("height") ]) wall_segment("top");
  }


  if( left ) {
    wall_stack();
  } else {
    mirror([1, 0, 0]) wall_stack();
  }


}

wall();

translate([ 3 * wall_attrs("width"), 0, 0 ]) wall(left=false);