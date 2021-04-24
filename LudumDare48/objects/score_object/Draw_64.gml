draw_set_colour(c_dkgray);
draw_rectangle(x, y, x + width, y + height, false);

draw_set_colour(c_white)
draw_text(x, y + 40, "Strokes: "+ string(global.strokes));

draw_set_colour(c_white)
draw_text(x + 200, y + 40, "Hole: "+ string(global.hole));

draw_set_colour(c_white)
draw_text(x + 700, y + 40, "x_speed: " + string(ball_object.x_speed) + ", y_speed: " + string(floor(ball_object.y_speed)));