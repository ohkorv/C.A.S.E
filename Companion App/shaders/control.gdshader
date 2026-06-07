shader_type canvas_item;

// This line fixes the error you are seeing
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;

void fragment() {
    // Now the shader uses the uniform we defined above
    COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
}