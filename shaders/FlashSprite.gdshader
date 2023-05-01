shader_type canvas_item;

uniform vec4 flash_color : source_color;
uniform float flash_intensity : hint_range(0, 1);
uniform float invincibility_instensity : hint_range(0,1);

void fragment(){
	COLOR = texture(TEXTURE, UV);
	//if (COLOR.r + COLOR.g + COLOR.b > 0.1)
	COLOR.rgb = mix(COLOR, flash_color, flash_intensity).rgb;
}