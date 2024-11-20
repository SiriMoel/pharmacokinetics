vec3 pharma_color_hsv = pharma_rgb2hsv(color);
vec3 pharma_color_rgb = pharma_hsv2rgb(pharma_color_hsv);

// purple time :)
if (pharma_datura_effect_amount.x > 0.0) {
    color.r -= (0.2 * pharma_datura_effect_amount.x);
    color.g -= (0.4 * pharma_datura_effect_amount.x);
    color.b -= (0.2 * pharma_datura_effect_amount.x);
    pharma_color_hsv = pharma_rgb2hsv(color);   
}

// pharmadust
if (pharma_pharmadust_effect_amount.x > 0.0) {
    pharma_color_hsv.x -= (0.5 * pharma_pharmadust_effect_amount.x);
    pharma_color_hsv.y -= (0.65 * pharma_pharmadust_effect_amount.x);
    pharma_color_rgb = pharma_hsv2rgb(pharma_color_hsv);
    color = pharma_color_rgb;
}

// wizarddust
if (pharma_wizarddust_effect_amount.x > 0.0) {
    pharma_color_hsv.y += (0.5 * pharma_wizarddust_effect_amount.x);
    pharma_color_hsv.z += (0.1 * pharma_wizarddust_effect_amount.x);
    pharma_color_rgb = pharma_hsv2rgb(pharma_color_hsv);
    color = pharma_color_rgb;
}

// love
if (pharma_love_effect_amount.x > 0.0) {
    pharma_color_hsv.y += (0.3 * pharma_love_effect_amount.x);
    pharma_color_hsv.z += (0.3 * pharma_love_effect_amount.x);
    pharma_color_rgb = pharma_hsv2rgb(pharma_color_hsv);
    color = pharma_color_rgb;
}

color = color;