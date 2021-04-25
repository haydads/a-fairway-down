draw_set_valign(fa_middle);
draw_set_halign(fa_left);
if(center)
{
	draw_set_halign(fa_center);
}
draw_set_font(instruction_font);
draw_set_colour(c_white);
draw_text(x, y, string_upper(text));