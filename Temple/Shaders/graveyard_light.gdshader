shader_type canvas_item;

uniform float offset;

void fragment() {
	// The result is a number 0-1 that is higher the closer the x position of the pixel is to the middle of the object
	// 1-|2x-1|
	float center = 1.0 - abs(2.0 * UV.x - 1.0);
	
	// The threshold increases linearly the higher up the pixel is
	// So the higher up the pixel is, the closer it needs to be to the center to be set to the color
	// until the treshold exceeds 1, then even the pixels at the center wont meet the treshold
	// This gives the object a triangle-like shape.
	if (center < 1.0 - (UV.y + offset)) {
		discard;
	}
}
