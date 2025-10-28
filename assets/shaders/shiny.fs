#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

// Values of this variable:
// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
// !! change this variable name to your Shader's name
// YOU MUST USE THIS VARIABLE IN THE vec4 effect AT LEAST ONCE
extern PRECISION vec2 shiny;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply  
//        it by sprite_width _height
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// [Required] 
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

// "My" Stuff
vec3 hash33(vec3 p3) // https://www.shadertoy.com/view/4djSRW
{
	p3 = fract(p3 * vec3(0.1031, 0.1030, 0.0973));
    p3 += dot(p3, p3.yxz + 33.33);
    return fract((p3.xxy + p3.yxx) * p3.zyx);
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // UV-Map
	vec2 uv = ((texture_coords * image_details) - (texture_details.xy * texture_details.ba)) / texture_details.ba;
    vec3 uv3 = vec3(uv * 3.0, (shiny.g + time) * 0.25);
    // General Vars & Initial for Stars
    vec3 fv3 = floor(uv3);
    vec3 hf3 = hash33(fv3) + fv3;
    fv3 = hf3;
    hf3 -= uv3;
    float dist = abs(hf3.x) + abs(hf3.y) + abs(hf3.z);
    // Basic Logic for Stars
    for(float i = -1.0; i <= 1.; ++i) {
        for(float j = -1.0; j <= 1.; ++j) {
            for(float h = -1.0; h <= 1.; ++h) {
                if(abs(i) + abs(j) + abs(h) != 0.0) {
                    hf3 = floor(uv3) + vec3(i, j, h);
                    hf3 = hash33(hf3) + hf3;
                    vec3 copy = hf3;
                    hf3 -= uv3;
                    float dist_r = abs(hf3.x) + abs(hf3.y) + abs(hf3.z);
                    if(dist > dist_r) {
                        fv3 = copy;
                        dist = dist_r;
                    }
                }
            }
        }
    }
    // Magic Sauce
    float ret = 0.0;
    vec4 tex = vec4(fv3, 1.0);
    dist = sqrt(abs(uv3.x - tex.x)) + sqrt(abs(uv3.y - tex.y)) + sqrt(abs(uv3.z - tex.z));
    // This Determines Star-Size
    if(dist <= 0.75) { ret += 1.0; } // Solid Outline
    if(dist <= 0.65) { ret -= 0.5; } // Transparent Core
    // Vignette
    uv *= 1.0 - uv.yx;
    ret *= (uv.x * uv.y * 20.0);
    // Color Mod.
    tex = vec4(colour.x, colour.y, colour.z * 0.2, ret) * 4.0;
    // "texture2D"
    tex = Texel(texture, texture_coords) * ret * tex;
    // Adding a very slight Shining effect (from Negative)
	uv = ((texture_coords * image_details) - (texture_details.xy * texture_details.ba)) / texture_details.ba;
	number delta = max(tex.r, max(tex.g, tex.b)) - min(tex.r, min(tex.g, tex.b)) - 0.1;
    number fac = max(0.8 + 0.9 * sin(11.0 * uv.x + 4.32 * uv.y + shiny.r * 12.0 + cos(shiny.r * 5.3 + uv.y * 4.2 - uv.x *4.0)), 0.2);
    tex.rgb = tex.rgb * 0.8 + vec3(1.0, 1.0, 0.2);
    tex.r = tex.r - delta + delta * fac * 0.7 - 0.1;
    tex.g = tex.g - delta + delta * fac * 0.7 - 0.1;
    tex.b = tex.b - delta + delta * fac * 0.35 - 0.1;
    // Return
    return dissolve_mask(tex, texture_coords, uv * 2.);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// for transforming the card while your mouse is on it
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
