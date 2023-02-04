shader_type spatial;

uniform sampler2D tex;
uniform vec3 rim_color: source_color = vec3(1.0f);

void fragment() {
	vec4 texcol = texture(tex, UV);
	float a = smoothstep(1.f, 0.f, 2.f * distance(UV, vec2(0.5f, 0.5f)));
	ALBEDO = (texcol.rgb + COLOR.rgb) * 0.5f * (a * rim_color);
	ALPHA = texcol.a * COLOR.a * a;
	RIM = 1.0f;
	RADIANCE = texcol;
	IRRADIANCE = texcol;
}
