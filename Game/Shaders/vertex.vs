vec4 lovrmain()
{
	// return DefaultPosition;
	return Projection * View * Transform * VertexPosition;
}