draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_self();
draw_set_colour(c_white);
if(point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
{
	if(mouse_check_button_pressed(mb_left))
	{
		action();	
	}
	draw_set_colour(c_yellow)
}
draw_text(x, y, string_upper(text));