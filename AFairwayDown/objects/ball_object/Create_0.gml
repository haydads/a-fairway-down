function initialise_ball()
{
	x_speed = 0;
	y_speed = 0;
	x_fraction = 0;
	y_fraction = 0;
	max_speed = 500;
	_gravity = 0.5;
	can_move = false;
	grounded = false;
	clicked = false;
	clicked_x = 0;
	clicked_y = 0;
	respawn_x = 0;
	respawn_y = 0;
	in_water = false;
	in_sand = false;
}
function check_mouse_input()
{
	if(can_move) and grounded and (y_speed == 0) and (x_speed == 0)
	{
		if (!clicked)
		{
		    var _left_click = mouse_check_button_pressed(mb_left);
		    if (_left_click)
			{
		        clicked = true;
				clicked_x = mouse_x;
				clicked_y = mouse_y;
		    }
		}
		else if (clicked)
		{
		    var _right_click = mouse_check_button_released(mb_right);
			if(_right_click)
			{
				clicked = false;
				exit;
			}
			
			var _left_released = mouse_check_button_released(mb_left);
		    if (_left_released)
			{
				audio_play_sound(ball_hit_sound, 10, false);
				var _direction = point_direction(mouse_x, mouse_y, clicked_x, clicked_y);
				var _distance = point_distance(mouse_x, mouse_y, clicked_x, clicked_y);

				_distance = clamp(_distance, 0, max_speed);
		
		        x_speed = lengthdir_x(_distance / 10, _direction);
		        y_speed = lengthdir_y(_distance / 10, _direction);
				global.strokes += 1;
				clicked = false;
				clicked_x = 0;
				clicked_y = 0;
		    }
		}
	}
	else
	{
		clicked = false;	
	}
}
function get_ball_movement()
{	
	//x_speed += x_fraction;
	//y_speed += y_fraction;
	
	//x_fraction = x_speed - (floor(abs(x_speed)) * sign(x_speed));
	//y_fraction = y_speed - (floor(abs(y_speed)) * sign(y_speed));
	
	//x_speed -= x_fraction;
	//y_speed -= y_fraction;
	
	check_wall_collision();
	check_sand_collision();
	check_green_collision();
	check_water_collision();
	check_lava_collision();
	check_boost_collision();
	check_start_collision();
	check_hole_collision();
	check_plug_collision();

	
	//Add Movement
	x += x_speed;
	y += y_speed;
}
function check_wall_collision()
{
	grounded = (place_meeting(x, y + 1, wall_object)) or (place_meeting(x, y + 1, green_object)) or (place_meeting(x, y + 1, sand_object));
	if (!grounded)
	{
	    y_speed += _gravity;
	} 
	else 
	{
	    if (abs(0 - x_speed) > 0.5)
		{
	        x_speed -= x_speed / 20;
	    }
		else 
		{
	        x_speed = 0;
	    }
	}
	
	if (place_meeting(x + x_speed, y, wall_object))
	{
	    while (!place_meeting(x + sign(x_speed), y, wall_object))
		{
	        x += sign(x_speed);
	    }
	    x_speed = -x_speed / 3//2;
	}

	if (place_meeting(x, y + y_speed, wall_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), wall_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 2//1.5;
	}
	
	if (grounded) and (abs(0 - y_speed) < 1)
	{
		y_speed = 0;
	}	
}
function check_sand_collision()
{
	if (place_meeting(x + x_speed, y, sand_object))
	{
	    while (!place_meeting(x + sign(x_speed), y, sand_object))
		{
	        x += sign(x_speed);
	    }
	    x_speed = -x_speed / 2;
	}
	
	if (place_meeting(x, y + y_speed, sand_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), sand_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 3;
		x_speed = x_speed / 5;
	}
}
function check_green_collision()
{
	if (place_meeting(x + x_speed, y, green_object))
	{
	    while (!place_meeting(x + sign(x_speed), y, green_object))
		{
	        x += sign(x_speed);
	    }
		x_speed = -x_speed / 3//2;
	}
	if (place_meeting(x, y + y_speed, green_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), green_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 5//2;
		x_speed = x_speed / 1.5//2;
	}	
}
function check_water_collision()
{
	
	if (place_meeting(x, y, water_object))
	{
		y_speed = y_speed / 1.1;
		x_speed = x_speed / 1.1;
		if(in_water == false)
		{
			in_water = true;
		}
	}
	else
	{
		in_water = false;	
	}
}
function check_lava_collision()
{
	
	if (place_meeting(x, y, lava_object))
	{
		x = respawn_x;
		y = respawn_y;
		x_speed = 0;
		y_speed = 0;
		global.strokes++;
	}
}
function check_boost_collision()
{
	var _boost = instance_place(x, y, boost_object);
	if (_boost != noone)
	{
	    audio_play_sound(boost_pad_sound, 10, false);	
		//show_debug_message(string(_boost.image_angle))

		switch(floor(_boost.image_angle))
		{
			case 0:
				y_speed = -25;
				break;
				
			case 90:
				x_speed = -25;
				break;
				
			case 180:
				y_speed = 25
				break;
				
			case 270:
				x_speed = 25;
				break;
		}
		_boost.image_index = 1;
	}
}
function check_hole_collision()
{
	var _hole = instance_place(x, y, hole_object);
	
	if(_hole != noone)
	{
		can_move = false;
		audio_play_sound(finish_hole_sound, 10, false);
		global.hole += 1;
		go_to_hole(global.hole);
		global.hole = clamp(global.hole, 0, 18);
		instance_destroy(_hole);
		x = _hole.x + 20;
		y = _hole.y;
		y_speed = 0;
		x_speed = 0;
	}
}
function check_plug_collision()
{
	var _plug = instance_place(x, y, plug_object);
	
	if(_plug != noone)
	{
		_plug.countdown = 20;
	}
}
function check_start_collision()
{
	var _start = instance_place(x, y, start_object);
	
	if(_start != noone)
	{
		x = _start.x + 20;
		y = _start.y + 24;
		respawn_x = x;
		respawn_y = y;
		y_speed = 0;
		x_speed = 0;
		instance_destroy(_start);
	}
}

initialise_ball();