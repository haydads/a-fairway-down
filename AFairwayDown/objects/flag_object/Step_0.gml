if(state.current == state.up)
{
	y -= move_speed;
	if(y == max_y)
	{
		state.current = state.down;	
	}
}
else if(state.current == state.down)
{
	y += move_speed;
	if(y == min_y)
	{
		state.current = state.up;	
	}
}