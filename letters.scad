$fn = $preview ? 12 : 64;

// letterbox thickness is ~17.5mm
// screw recommends drill hole of 2mm diameter
// measured max screw diameter is 2.85mm

module main () {
  letter3d(
    char = "/",
    char_size = 50,
    height = 2,
    with_holes = true,
    hole_radius = 1.2
  );
}

module letter3d (char, char_size, height = 2, with_holes, hole_radius) {
  linear_extrude(height = height)
    letter2d(
      char = char,
      char_size = char_size,
      with_holes = with_holes,
      hole_radius = hole_radius
    );
}

module letter2d (char, char_size, with_holes = false, hole_radius) {
  difference() {
    letter2d_text(char = char, char_size = char_size);

    if (with_holes) {
      letter2d_holes(char = char, char_size = char_size, hole_radius = hole_radius);
    }
  }
}

module letter2d_text(char, char_size = 10) {
  text(
    text = char,
    size = char_size,
    // font = "DejaVu Sans Mono:style=Bold",
    // font = "Ubuntu Mono:style=Bold",
    font = "Bitstream Vera Sans Mono:style=Bold",
    // font = "Noto Sans Mono:style=Bold",
    halign = "center"
  );
}

module letter2d_holes(char, char_size = 10, hole_radius = 2) {
  offset_x_top =
    char == "1" ? char_size / 30
    : char == "4" ? char_size / 6.40
    : char == "/" ? char_size / 4.2
    : 0;

  offset_x_bottom =
    char == "7" ? -char_size / 10.5
    : char == "/" ? -char_size / 6
    : offset_x_top;
    

  offset_y = char_size / 15;

  union() {
    translate([offset_x_top, char_size - offset_y])
      circle(r = hole_radius);

    translate([offset_x_bottom, offset_y])
      circle(r = hole_radius);
  }
}

main();
