{ subnet, components, contracts }:

subnet {
 src = ./.;
 subnet = with components; with contracts; ''
 '${maths_boolean}:(boolean=false)' -> input not(${maths_boolean_not}) output -> input disp(${maths_boolean_print})
 '';
}
