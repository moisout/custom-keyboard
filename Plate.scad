// All measurements in mm

// inner_case_length = 421;
// inner_case_width = 121;
// inner_case_height = 15;

plate_length = 428.72;
plate_width = 124.083;
plate_height = 5;

offset_delta = -0.85;

// module screw_mount(x, y)
// {
//   translate([ -(inner_case_length / 2) + x, -(inner_case_width / 2) + y, 0 ])
//   {
//     $fn = 50;
//     difference()
//     {
//       translate([ 0, 0, -0.85 ])
//       {
//         cylinder(h = inner_case_height - 4, r = 2, center = true);
//       }
//       translate([ 0, 0, inner_case_height / 4 ])
//       {
//         cylinder(h = inner_case_height / 2, r = 1, center = true);
//       }
//     }
//     translate([ 0, 0, -(inner_case_height / 2) + 3 ])
//     {
//       cube([ 10, 2, 4 ], center = true);
//       cube([ 2, 10, 4 ], center = true);
//     }
//   }
// }

module replace_plate_cutout(x, y, w, h)
{
  translate([- (plate_length / 2), - (plate_width / 2), 1])
  {
    translate([x, y, -18.5])
    cube([ w, h, 22 ], center = false);
  }
}

module replace_plate_part(x, y, w, h)
{
  translate([- (plate_length / 2), - (plate_width / 2), 4.5])
  {
    difference()
    {
      linear_extrude(height = 1.5, center = false, convexity = 10)
        import (file = "src/plate_layout_mk2.dxf");
        

      difference()
      {
        translate([-1, -1, -1])
        cube([ plate_length + 2, plate_width + 2, 20 ], center = false);

        translate([x, y, -2])
        cube([ w, h, 22 ], center = false);
      }
    }
  }
}

// Top left to bottom right
stabilizer_cutouts = [
  // #1
  [plate_length - 75.15, 1.1, 36, 15.063],

  // #2
  [plate_length - 75.15, 1.1, 36, 15.063],

  // #3
  [241.6, 20, 36, 15.063],

  // #4
  [plate_length - 75.15, 1.1, 36, 15.063],

  // #5
  [plate_length - 20, 40.45, 16.9, 34],

  // #6
  [plate_length - 20, 2.3, 16.9, 34],

  // Spacebar
  [plate_length - 75.15, 1.1, 36, 15.063],
];

stabilizers = [
  // #1 Backspace, horizontal
  [plate_length - 74.2, 1.1, 9.21, 16.9],
  [plate_length - 49.3, 1.1, 9.21, 16.9],

  // #2 Enter, vertical
  [plate_length - 74.2, 1.1, 9.21, 16.9],
  [plate_length - 49.3, 1.1, 9.21, 16.9],

  // #3 RShift, horizontal
  [plate_length - 74.2, 1.1, 9.21, 16.9],
  [plate_length - 49.3, 1.1, 9.21, 16.9],

  // #4 Numpad 0, horizontal
  [plate_length - 74.2, 1.1, 9.21, 16.9],
  [plate_length - 49.3, 1.1, 9.21, 16.9],

  // #5 Numpad +, vertical
  [plate_length - 20, 40.45, 16.9, 9.21],
  [plate_length - 20, 65.2, 16.9, 9.21],

  // #6 Numpad enter, vertical
  [plate_length - 20, 2.3, 16.9, 9.21],
  [plate_length - 20, 27.1, 16.9, 9.21],

  // Spacebar
  [plate_length - 74.2, 1.1, 9.21, 16.9],
  [plate_length - 49.3, 1.1, 9.21, 16.9],
];

module keyboard_plate()
{
  difference()
  {
    translate([- (plate_length / 2), - (plate_width / 2), 1])
    {
      difference()
      {
        linear_extrude(height = plate_height, center = false, convexity = 10)
          offset(delta = offset_delta) {  
            import (file = "src/plate_layout_mk2.dxf");
          }

        translate([ -1, plate_width / 2 + 35, -1 ])
        cube([ plate_length + 2, plate_width, 20 ], center = false);
      }
      difference()
      {
        translate([ 0, -4.4, 0 ])
        linear_extrude(height = plate_height, center = false, convexity = 10)
          offset(delta = offset_delta) {  
            import (file = "src/plate_layout_mk2.dxf");
          }

        translate([ -1, -27.1, -1 ])
        cube([ plate_length + 2, plate_width, 20 ], center = false);
      }
    }

    for (i=[0:(len(stabilizer_cutouts)-1)]) {
      stab_values = stabilizer_cutouts[i];
      replace_plate_cutout(stab_values[0], stab_values[1], stab_values[2], stab_values[3]);
    }
  }

  for (i=[0:(len(stabilizers)-1)]) {
    stab_values = stabilizers[i];
    replace_plate_part(stab_values[0], stab_values[1], stab_values[2], stab_values[3]);
  }
}

module cutout_center()
{
  cube([ plate_length / 1.22, plate_width + 4, 20 ], center = true);
}

module cutout_left()
{
  translate([ - (plate_length / 3) - 1, 0, 0 ])
  {
    cube([ plate_length / 3 + 2.01, plate_width + 4, 20 ],
         center = true);
  }
}

module cutout_right()
{
  translate([ (plate_length / 3) + 1, 0, 0 ])
  {
    cube([ plate_length / 3 + 2.01, plate_width + 4, 20 ],
         center = true);
  }
}

difference()
{
  keyboard_plate();
  // cutout_left();
  // cutout_center();
  // cutout_right();
}
