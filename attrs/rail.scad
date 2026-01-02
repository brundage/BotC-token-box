use <util/g.scad>
use <attrs/token_tray.scad>

attrs = [
  [ "width", 4.0 ],
  [ "depth", token_tray_attrs("depth") ],
  [ "height", 3.0 + token_tray_attrs("bottom thickness") ],
];

function rail_attrs(attr=undef) = attr == undef ? function(attr) rail_attrs(attr) : g(attr, attrs);