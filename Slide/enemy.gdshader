shader_type canvas_item;

uniform float red = 1.0;

void fragment() {
	// Place fragment code here.
	COLOR = texture(TEXTURE, UV);
	COLOR.r = red;
}
