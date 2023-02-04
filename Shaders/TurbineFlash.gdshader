shader_type spatial;

uniform float max_opacity = 1.f;
uniform vec3 tint : source_color = vec3(1.f);

const float RING_PERCENTAGE =  0.5f;

void fragment() {
	float dist = distance(UV, vec2(.5f, .5f)) * 2.f;
	dist = step(RING_PERCENTAGE, dist) * dist;
	ALPHA = max(0.f, (1.f - dist) * max_opacity);
	ALBEDO = tint;
}
