/*
Parametric hook for HSW

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
hook_length = 22.3;
hook_diameter = 6.6;
hook_nose_height = 1;
slope_height = 0.4;

_hook_total_length = hook_length + hook_diameter / 2 + hook_nose_height;


const_hsw_diameter = 15.47; // 15.15 mm hooks slide in and out with ease. 15.47 mm is quite tight.


_hsw_inner_circle_diameter = (sqrt(3) / 2) * const_hsw_diameter;
_hook_inner_circle_radius = (sqrt(3) / 2) * hook_diameter;
echo(_hsw_inner_circle_diameter)
echo(_hook_inner_circle_radius)

// HSW insert
cylinder(d=const_hsw_diameter, h=insert_length, $fn=6);

// Hook
translate([0, 0 - (_hsw_inner_circle_diameter / 2) + (_hook_inner_circle_radius / 2), insert_length]) cylinder(d=hook_diameter, h=_hook_total_length, $fn=6);

// Fillet
difference () {
    translate([-hook_diameter / 4, -_hsw_inner_circle_diameter/2 + _hook_inner_circle_radius, insert_length + _hook_total_length - hook_diameter/2 - min(hook_diameter, hook_nose_height * 2) / 2])
    cube([hook_diameter / 2, min(hook_diameter / 2, hook_nose_height), min(hook_diameter / 2, hook_nose_height)]);
    translate([-hook_diameter / 4, -_hsw_inner_circle_diameter/2 + _hook_inner_circle_radius + min(hook_diameter, hook_nose_height * 2)/2,insert_length + _hook_total_length - hook_diameter/2 - min(hook_diameter, hook_nose_height * 2) / 2])
    rotate([0, 90, 0])cylinder(d=min(hook_diameter, hook_nose_height * 2) , h=hook_diameter/2, $fn=64);
}

// Hook Nose
translate([0, 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_nose_height / 2, insert_length + _hook_total_length - hook_diameter / 4])
cube([hook_diameter / 2, hook_nose_height, hook_diameter / 2], center=true);

// Hook Nose Top Pyramid
translate([0, 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_nose_height + (slope_height / 2), insert_length + _hook_total_length - hook_diameter / 4])
rotate([90, 45, 0])
cylinder(d2=hook_diameter / 2 * sqrt(2), d1=0, h = slope_height, center=true, $fn=4);
