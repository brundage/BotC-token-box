use <util/g.scad>

attrs = [
  // [ "wall thickness",        1.0 ],
  // [ "sub module attrs",      function(attr=undef) sub_module_attrs(attr) ],
  // [ "sub module 2 property", sub_module_2_attrs("property") ],
];

function REPLACE_attrs(attr=undef) = attr == undef ? function(attr) REPLACE_attrs(attr) : g(attr, attrs);