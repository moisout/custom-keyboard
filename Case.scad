// All measurements in mm

inner_length = 421;
inner_width = 121;
inner_height = 15;

wall_thickness = 2;

outer_length = inner_length + (wall_thickness * 2);
outer_width = inner_width + (wall_thickness * 2);
outer_height = inner_height;

module keyboard_case()
{
  difference()
  {
    // Outer shell
    hull()
    {
      o_le_h = outer_length / 2;
      o_wi_h = outer_width / 2;
      o_he_h = outer_height / 2;

      slantedness = 10;

      polyhedron(
        points = [
          [ -o_le_h, o_wi_h, o_he_h ],
          [ o_le_h, o_wi_h, o_he_h ],
          [ o_le_h, -o_wi_h, o_he_h ],
          [ -o_le_h, -o_wi_h, o_he_h ],

          [ -o_le_h, o_wi_h, -o_he_h - slantedness ],
          [ o_le_h, o_wi_h, -o_he_h - slantedness ],
          [ o_le_h, -o_wi_h, -o_he_h ],
          [ -o_le_h, -o_wi_h, -o_he_h ]
        ],
        faces = [
          [ 0, 1, 2, 3 ],
          [ 0, 3, 4, 7 ],
          [ 0, 1, 4, 5 ],
          [ 1, 2, 5, 6 ],
          [ 2, 3, 7, 6 ],
          [ 4, 5, 6, 7 ]
        ]);
    }

    // Outer shell cutout
    translate([ 0, 0, wall_thickness ])
    {
      cube([ inner_length, inner_width, inner_height ], center = true);
    }

    // Port for cable
    translate([ 0, inner_width / 2, -2.5 ])
    {
      cube([ 12, 10, 6 ], center = true);
    }
  }
  // Top pcb holder
  translate([ 0, inner_width / 2 - 1, inner_height / 2 - 6 ])
  {
    cube([ inner_length, 4, 3 ], center = true);
  }

  // Bottom pcb holder inner
  b_pcb_h_width = inner_length - 40;
  translate([
    -(b_pcb_h_width / 2), -(inner_width / 2) + 17, -(inner_height / 2) + 2
  ])
  {
    cube([ b_pcb_h_width, 2, inner_height / 2 + 1 ]);
  }

  // Bottom pcb holder outer
  translate(
      [ -(inner_length / 2), -(inner_width / 2) + 17, -(inner_height / 2) + 2 ])
  {
    cube([ inner_length, 2, inner_height / 2 - 2 ]);
  }

  // Middle bottom pcb holder
  m_b_pcb_h_width = 240;
  translate([ -(inner_length / 2) - 1, -4, -(inner_height / 2) + 2 ])
  {
    cube([ m_b_pcb_h_width, 2, inner_height / 2 + 1 ]);
  }

  // Middle top pcb holder inner
  m_t_pcb_h_width = 100;
  translate([
    (inner_length / 2) - m_t_pcb_h_width - 15, 14, -(inner_height / 2) + 2
  ])
  {
    cube([ m_t_pcb_h_width, 2, inner_height / 2 + 1 ]);
  }

  // Middle top pcb holder outer
  translate([ (inner_length / 2) - 99, 14, -(inner_height / 2) + 2 ])
  {
    cube([ 100, 2, inner_height / 2 - 2 ]);
  }

  // Stability parts

  stabilizer_x = 2;
  stabilizer_y = inner_width + 2;
  stabilizer_z = 5;

  stabilizer_pos_y = -(inner_height / 2) + stabilizer_z - 1;

  translate([ -inner_length / 2.5, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  translate([ -inner_length / 10, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  translate([ -inner_length / 4, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  translate([ inner_length / 2.5, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  translate([ inner_length / 4, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  translate([ inner_length / 10, 0, stabilizer_pos_y ])
  {
    cube([ stabilizer_x, stabilizer_y, stabilizer_z ], center = true);
  }

  // Screw mounts for top plate
  module screw_mount(x, y)
  {
    translate([ -(inner_length / 2) + x, -(inner_width / 2) + y, 0 ])
    {
      $fn = 50;
      difference()
      {
        translate([ 0, 0, -0.85 ])
        {
          cylinder(h = inner_height - 4, r = 2, center = true);
        }
        translate([ 0, 0, inner_height / 4 ])
        {
          cylinder(h = inner_height / 2, r = 1, center = true);
        }
      }
      translate([ 0, 0, -(inner_height / 2) + 3 ])
      {
        cube([ 10, 2, 4 ], center = true);
        cube([ 2, 10, 4 ], center = true);
      }
    }
  }

  // Top left to bottom right

  // Top row
  screw_mount(54.5, 109.5);
  screw_mount(139, 109);
  screw_mount(225.5, 109.5);
  screw_mount(305, 109);
  screw_mount(404, 109);

  // Middle row
  screw_mount(82.5, 57.5);
  screw_mount(161.5, 57.5);
  screw_mount(412, 38);

  // Bottom row
  screw_mount(22.2, 3.9);
  screw_mount(114, 4);
  screw_mount(212, 8);
  screw_mount(305, 10);
  screw_mount(384, 4);
}

module cutout_center()
{
  cube([ outer_length / 3, outer_width + 4, outer_height + 20 ], center = true);
}
module cutout_left()
{
  translate([ -(outer_length / 3) - 1, 0, 0 ])
  {
    cube([ outer_length / 3 + 2.01, outer_width + 4, outer_height + 20 ],
         center = true);
  }
}
module cutout_right()
{
  translate([ (outer_length / 3) + 1, 0, 0 ])
  {
    cube([ outer_length / 3 + 2.01, outer_width + 4, outer_height + 20 ],
         center = true);
  }
}
module cutout_test()
{
  rotate(45) translate([ (outer_length / 3) + 1, 0, 0 ])
  {
    cube([ outer_length + 150, , outer_width * 10, outer_height + 20 ], ,
         center = true);
  }
}
difference()
{
  keyboard_case();
  // cutout_test();
  // cutout_left();
  cutout_center();
  cutout_right();
}
