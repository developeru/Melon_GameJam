shader_type canvas_item;

uniform float a:hint_range(0.0, 1.0) = 0.2; 
uniform float b:hint_range(0.0, 1.0) = 0.3; 
uniform float h:hint_range(0.0, 1.0) = 0.5; 
uniform float k:hint_range(0.0, 1.0) = 0.6;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment()
{
    vec2 uv = floor(UV / TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
    float r = step(((uv.x - h)*(uv.x - h))/(a*a) + ((uv.y - k)*(uv.y - k))/(b*b), 1.0);
    COLOR = mix(vec4(0.0, 0.0, 0.0, 0.0), texture(TEXTURE, UV), r);
}