// Turns a rectangle into a triangle
shader_type canvas_item;

uniform float offset;

// The result is a number 0-1 that is lower the closer the x position of the pixel is to the middle of the object
float distance_to_middle(float x) {
	// 1-|2x-1|
	return 1.0 - abs(2.0 * x - 1.0);
}

void fragment() {
	// The threshold increases linearly the higher up the pixel is
	// So the higher up the pixel is, the closer it needs to be to the center to be set to the color
	// until the treshold exceeds 1, then even the pixels at the center wont meet the treshold
	// This gives the object a triangle-like shape.
	// 1-|2x-1| < 1-y
	// 1-abs(2x-1) < y (If plugging into desmos, since y is inverted in computer graphics. All colored values would be discarded. We only care about values 0-1, since that is the range of the uv)
	if (distance_to_middle(UV.x) < 1.0 - (UV.y + offset)) {
		discard;
	}
}
