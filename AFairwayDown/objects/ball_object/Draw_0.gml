
draw_self();
if(clicked)
{
	var _aim_direction = point_direction(mouse_x, mouse_y, clicked_x, clicked_y);
	var _aim_distance = point_distance(mouse_x, mouse_y, clicked_x, clicked_y);
		
	var _aim_x = x + lengthdir_x(_aim_distance, _aim_direction);
	var _aim_y = y + lengthdir_y(_aim_distance, _aim_direction);
	
	draw_set_colour(c_yellow);
	draw_line(x, y, _aim_x, _aim_y);
	draw_sprite_ext(aim_sprite, 0, _aim_x, _aim_y, 1, 1, _aim_direction, c_yellow, 1);
}