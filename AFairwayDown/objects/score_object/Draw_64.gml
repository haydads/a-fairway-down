draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_colour(c_black);
draw_rectangle(x, y, x + width, y + height, false);

draw_set_halign(fa_center);
draw_set_colour(c_white);
if(global.strokes == 1)
{
	draw_text(x + 960, y + 40, string(global.strokes) + " Hit");
}
else
{
	draw_text(x + 960, y + 40, string(global.strokes) + " Hits");
}

draw_set_halign(fa_left);
draw_set_colour(c_white)
if(global.current_hits == 1)
{
	draw_text(x + 40, y + 40, "Hole "+ string(global.hole) + " - " + string(global.current_hits) + " Hit");
}
else
{
	draw_text(x + 40, y + 40, "Hole "+ string(global.hole) + " - " + string(global.current_hits) + " Hits");
}
draw_set_halign(fa_right);
draw_set_colour(c_white)
draw_text(room_width - 40, y + 40, "Press ESC to Quit");

draw_set_colour(c_white)
//draw_text(x + 700, y + 40, "x_speed: " + string(ball_object.x_speed) + ", y_speed: " + string(floor(ball_object.y_speed)));