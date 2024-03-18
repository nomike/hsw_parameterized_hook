/*
    hsw_parametric_hook - OpenSCAD script to generate hooks for the Honeycomb Storage Wall (HSW) system
    Copyright (C) 2024  nomike[AT]nomike[DOT]com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

insert_length = 13;
hook_length = 25.5;
hook_diameter = 5;
hook_nose_height = 5;
slope_height = 1;

const_hsw_diameter = 15.29; // 15.15 mm hooks slide in and out with ease. 15.29 mm is neatly tight.



_hsw_inner_circle_diameter = (sqrt(3) / 2) * const_hsw_diameter;
_hook_inner_circle_radius = (sqrt(3) / 2) * hook_diameter;
echo(_hsw_inner_circle_diameter)
echo(_hook_inner_circle_radius)

// HSW insert
cylinder(d=const_hsw_diameter, h=insert_length, $fn=6);

// Hook
translate([0, 0 - (_hsw_inner_circle_diameter / 2) + (_hook_inner_circle_radius / 2), insert_length]) cylinder(d=hook_diameter, h=hook_length, $fn=6);

// Fillet
difference() {
    translate([0, 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_diameter / 4, insert_length + hook_length - hook_diameter / 4 - hook_diameter / 2])
    color("black") cube([hook_diameter / 2, hook_diameter / 2, hook_diameter / 2], center=true);
    translate([0 - (hook_diameter / 4), 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_diameter / 4 + hook_diameter/4, insert_length + hook_length - hook_diameter / 2 - hook_diameter / 2], $fn=32) rotate([0, 90, 0]) cylinder(d=hook_diameter, h=hook_diameter / 2);
}

// Hook Nose
translate([0, 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_nose_height / 2, insert_length + hook_length - hook_diameter / 4])
cube([hook_diameter / 2, hook_nose_height, hook_diameter / 2], center=true);

// Hook Nose Top Pyramid
translate([0, 0 - (_hsw_inner_circle_diameter / 2)  + _hook_inner_circle_radius + hook_nose_height + (slope_height / 2), insert_length + hook_length - hook_diameter / 4])
rotate([90, 45, 0])
cylinder(d2=hook_diameter / 2 * sqrt(2), d1=0, h = slope_height, center=true, $fn=4);
