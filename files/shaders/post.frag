// doublevision kinda? (this does not do what it does in post_final.frag (very confusing))
/*if ( pharma_datura_effect_amount.x > 0.5) {
    vec2 pharma_datura_doublevision_offset = vec2(0.005 * cos(time * 0.5) * (pharma_datura_effect_amount.x * 0.01), 0.005 * sin(time * 0.5) * (pharma_datura_effect_amount.x * 0.01));
    color_fg = mix(color_fg, texture2D(tex_fg, tex_coord + pharma_datura_doublevision_offset), 0.5);
    color = mix(color, texture2D(tex_bg, tex_coord + pharma_datura_doublevision_offset).rgb, 0.5);
}*/

// purple time :)
color.r -= (0.2 * pharma_datura_effect_amount.x);
color.g -= (0.4 * pharma_datura_effect_amount.x);
color.b -= (0.2 * pharma_datura_effect_amount.x);

// pharmadust
vec3 pharma_color_hsv = pharma_rgb2hsv(color);
pharma_color_hsv.x -= (0.5 * pharma_pharmadust_effect_amount.x);
pharma_color_hsv.y -= (0.65 * pharma_pharmadust_effect_amount.x);
color = pharma_hsv2rgb(pharma_color_hsv);

// wizarddust
pharma_color_hsv.y += (0.5 * pharma_wizarddust_effect_amount.x);
pharma_color_hsv.z += (0.1 * pharma_wizarddust_effect_amount.x);
color = pharma_hsv2rgb(pharma_color_hsv);