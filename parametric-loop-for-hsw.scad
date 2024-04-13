/*
Parametric loop for HSW

Copyright 2024 nomike[AT]nomike[DOT]com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


insert_length = 13;
hole_width = 25;
hole_length = 3;
loop_heigth = 7;
wall_thickness = 2;
closed_bottom = false;


loop_width = hole_width + wall_thickness * 2;
loop_length = hole_length + wall_thickness * 2;

const_hsw_diameter = 15.35; // 15.15 mm hooks slide in and out with ease. 15.47 mm is quite tight.
_hsw_inner_circle_diameter = (sqrt(3) / 2) * const_hsw_diameter;


// HSW insert
cylinder(d=const_hsw_diameter, h=insert_length, $fn=6);

loop_y_shift = 0;

// Loop
translate([0, 0 - (_hsw_inner_circle_diameter / 2) + (loop_heigth / 2), (loop_length / 2) + insert_length])
difference() {
    cube([loop_width, closed_bottom ? loop_heigth + wall_thickness: loop_heigth, loop_length], center=true);
    translate([0, closed_bottom ? wall_thickness : 0, 0]) cube([hole_width, closed_bottom ? loop_heigth : loop_heigth, hole_length], center=true);
    
}


