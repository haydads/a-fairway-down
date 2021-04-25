if(countdown != -1)
{
	countdown--;
	if(countdown == 0)
	{
		instance_create_layer(x, y, "objects", wall_object);
		instance_destroy(self);
	}
}