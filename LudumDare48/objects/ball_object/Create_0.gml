function initialise_ball()
{
	x_speed = 0;
	y_speed = 0;
	_gravity = 0.5;
	can_move = false;
	grounded = false;
	clicked = false;
	clicked_x = 0;
	clicked_y = 0;
	terrain_layer = layer_tilemap_get_id("terrain");
}
function check_mouse_input()
{
	if(can_move)
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
		    var _left_released = mouse_check_button_released(mb_left);
		    if (_left_released)
			{
		        audio_play_sound(ball_hit_sound, 10, false);
				var _direction = point_direction(mouse_x, mouse_y, clicked_x, clicked_y);
				var _distance = point_distance(mouse_x, mouse_y, clicked_x, clicked_y);

				_distance = clamp(_distance, 0, 500);
		
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
	check_wall_collision();
	check_sand_collision();
	check_green_collision();
	check_water_collision();
	check_boost_collision();
	check_start_collision();
	check_hole_collision();
	
	//Add Movement
	x += x_speed;
	y += y_speed;
}
function check_wall_collision()
{
	grounded = (place_meeting(x, y + 1, wall_object));
	if (!grounded)
	{
	    y_speed += _gravity;
	} 
	else 
	{
	    if (abs(0 - x_speed) > 0.01)//0.5)
		{
	        x_speed -= x_speed / 50//10;
	    }
		else 
		{
	        x_speed = 0;
	    }
	}
	
	//Horizontal collisions
	if (place_meeting(x + x_speed, y, wall_object))
	{
	    while (!place_meeting(x + sign(x_speed), y, wall_object))
		{
	        x += sign(x_speed);
	    }
	    x_speed = -x_speed / 2;
	}

	//Vertical collisions
	if (place_meeting(x, y + y_speed, wall_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), wall_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 1.5;
	}
	
	//Vertical movement
	if (grounded) and (abs(0 - y_speed) < 1)
	{
		y_speed = 0;
	}	
}
function check_sand_collision()
{
	//Horizontal collisions
	if (place_meeting(x + x_speed, y, sand_object))
	{
	    //while (!place_meeting(x + sign(x_speed), y, sand_object))
		//{
	    //    x += sign(x_speed);
	    //}
	    x_speed = 0;//-x_speed / 2;
	}

	//Vertical collisions
	if (place_meeting(x, y + y_speed, sand_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), sand_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 3;
		x_speed = x_speed / 3;
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
		x_speed = -x_speed / 2;
	}
	if (place_meeting(x, y + y_speed, green_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), green_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = -y_speed / 2;
	}	
}
function check_water_collision()
{
	if (place_meeting(x, y + y_speed, water_object))
	{
	    while (!place_meeting(x, y + sign(y_speed), water_object))
		{
	        y += sign(y_speed);
	    }
	    y_speed = y_speed / 1.75;
		x_speed = x_speed / 1.75;
	}	
}
function check_boost_collision()
{
	var _boost = instance_place(x, y, boost_object);
	if (_boost != noone)
	{
	    show_debug_message(string(_boost.image_angle))

		switch(floor(_boost.image_angle))
		{
			case 0:
				x_speed = 15;
				//y_speed = 0;
				break;
				
			case 90:
				//x_speed = 0
				y_speed = -15;
				break;
				
			case 180:
				x_speed = -15
				//y_speed = 0;
				break;
				
			case 270:
				//x_speed = 0;
				y_speed = 15;
				break;
		}
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
		instance_destroy(_hole);
		x = _hole.x + 20;
		y = _hole.y;
		y_speed = 0;
		x_speed = 0;
	}
}
function check_start_collision()
{
	var _start = instance_place(x, y, start_object);
	
	if(_start != noone)
	{
		x = _start.x + 20;
		y = _start.y + 24;
		y_speed = 0;
		x_speed = 0;
		instance_destroy(_start);
	}
}

initialise_ball();