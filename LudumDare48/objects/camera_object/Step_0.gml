move_camera();

var view_matrix = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var proj_matrix = matrix_build_projection_ortho(width, height, 1, 10000);

camera_set_view_mat(camera, view_matrix);
camera_set_proj_mat(camera, proj_matrix);

if(keyboard_check_pressed(ord("1")))
{
	go_to_hole(1);	
}
if(keyboard_check_pressed(ord("2")))
{
	go_to_hole(2);	
}