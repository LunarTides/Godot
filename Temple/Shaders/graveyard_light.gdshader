shader_type canvas_item;

uniform float weight = 0.2;
uniform float low_alpha = 0.0;
uniform float high_alpha = 0.5;

void fragment() {
	float result = (1.0 - 2.0 * abs(UV.x - 0.5)) * sqrt(UV.y);
	
	if (result < 1.0 - weight) {
		COLOR.a = low_alpha;
	} else if (result > 0.0) {
		COLOR.a = high_alpha;
	}
}
