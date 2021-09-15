// All measurements in mm

plate_length = 428.72;
plate_width = 124.083;
plate_height = 1.5;

module keyboard_plate()
{
  translate([- (plate_length / 2), - (plate_width / 2), 1])
  {
    linear_extrude(height = plate_height, center = false, convexity = 10)
      import (file = "src/plate_layout.dxf");
  }
}

module cutout_center()
{
  cube([ plate_length / 1.2, plate_width + 4, 20 ], center = true);
}
module cutout_left()
{
  translate([ -(plate_length / 3) - 1, 0, 0 ])
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
  cutout_center();
  cutout_right();
}
