shader_type canvas_item;

uniform vec4 bg;
uniform vec4 fg;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    if (color.rgb == vec3(0, 0, 0)) {
        COLOR.rgb = bg.rgb;
    } else {
        COLOR.rgb = fg.rgb;
    }
}
