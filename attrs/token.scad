use <util/g.scad>

character_token_attrs = [
  [ "diameter", 44.8 + 0.8 ],
  [ "thickness", 1.9 + 0.2 ]
];

function character_token_attrs(attr=undef) = attr == undef ? function(attr) character_token_attrs(attr) : g(attr, character_token_attrs);

reminder_token_attrs = [
  [ "diameter",  25.8 + 0.7 ],
  [ "thickness", 1.9 + 0.2 ],
];

function reminder_token_attrs(attr=undef) = attr == undef ? function(attr) reminder_token_attrs(attr) : g(attr, reminder_token_attrs);