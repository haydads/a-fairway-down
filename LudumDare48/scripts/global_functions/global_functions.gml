global.strokes = 0;
global.hole = 1;

function go_to_hole(_number)
{
	camera_object.target_y = (camera_object.height / 2) + (1000 * (_number - 1));
}