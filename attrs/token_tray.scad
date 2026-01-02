use <util/g.scad>
use <attrs/token_caddy.scad>

attrs = [
  [ "rows", 3 ],  // 307.7 mm
  [ "cols", 2 ],  // 256.55 mm
  [ "bottom thickness", 3.0 ],
  [ "height", 13 ],  // measured from token caddy render
  [ "depth", function() token_tray_attrs("rows") * token_caddy_attrs("depth") ],
  [ "width", function() token_tray_attrs("cols") * token_caddy_attrs("width") +
                        2 * token_tray_attrs("caddy tolerance")
  ],
  [ "caddy tolerance", 0.2 ],
];

function token_tray_attrs(attr=undef) = attr == undef ? function(attr) token_tray_attrs(attr) : g(attr, attrs);