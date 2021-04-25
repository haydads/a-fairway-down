function initialise_camera()
{
	height = 1080;
	width = 1920;
	center_x = width / 2;
	center_y = height / 2;
	
	x = center_x;
	y = center_y;
	
	target_y = 0;
	move_speed = 20;

	camera = camera_create();

	var _view_matrix = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
	var _projection_matrix = matrix_build_projection_ortho(width, height, 1, 10000);

	camera_set_view_mat(camera, _view_matrix);
	camera_set_proj_mat(camera, _projection_matrix);

	view_camera[0] = camera;
	go_to_hole(1);
}
function move_camera()
{
	if(y == target_y)
	{
		ball_object.can_move = true;
	}
	else
	{
		ball_object.can_move = false;
		
		if(y < target_y)
		{
			y += move_speed;
		}
		if(y > target_y)
		{
			y -= move_speed;
		}
	}
}

initialise_camera();