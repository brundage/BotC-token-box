use <util/g.scad>
use <attrs/token.scad>

attrs = [
  [ "font size", 8.0 ],
  [ "wall thickness",   1.6 ],
  [ "width", function() 1.9 * reminder_token_attrs("diameter") + token_caddy_attrs("wall thickness") ],
  [ "depth", function() 1.9 * reminder_token_attrs("diameter") + token_caddy_attrs("wall thickness") ],
];

function token_caddy_attrs(attr=undef) = attr == undef ? function(attr) token_caddy_attrs(attr) : g(attr, attrs);