use <util/g.scad>
use <attrs/token_tray.scad>
use <attrs/wall.scad>

attrs = [
  [ "bottom thickness", 4.0 ],
  [ "trays", 3 ],
  [ "width", function() token_tray_attrs("width") + wall_attrs("wall thickness") + 2 * tray_box_attrs("tray tolerance") ],
  [ "depth", token_tray_attrs("depth") ],
  [ "tray tolerance", 0.2 ],
  // [ "wall thickness",        1.0 ],
  // [ "sub module attrs",      function(attr=undef) sub_module_attrs(attr) ],
  // [ "sub module 2 property", sub_module_2_attrs("property") ],
];

function tray_box_attrs(attr=undef) = attr == undef ? function(attr) tray_box_attrs(attr) : g(attr, attrs);