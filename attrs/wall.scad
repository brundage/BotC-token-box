use <util/g.scad>
use <attrs/token_tray.scad>
use <attrs/rail.scad>

attrs = [
  [ "wall thickness", 4.0 ],
  [ "width", function() wall_attrs("wall thickness") + rail_attrs("width") ],
  [ "depth", token_tray_attrs("depth") ],
  [ "height", token_tray_attrs("height") ],
];

function wall_attrs(attr=undef) = attr == undef ? function(attr) wall_attrs(attr) : g(attr, attrs);