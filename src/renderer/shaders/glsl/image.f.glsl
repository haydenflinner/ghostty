#include "common.glsl"

layout(binding = 0) uniform sampler2D image;

in vec2 tex_coord;
in float grid_y;

layout(location = 0) out vec4 out_FragColor;

void main() {
    // Discard fragments that the grid translate moved outside of the
    // viewport area.
    if (grid_y < grid_clip.x || grid_y > grid_clip.y) {
        discard;
    }

    bool use_linear_blending = (bools & USE_LINEAR_BLENDING) != 0;

    vec4 rgba = texture(image, tex_coord);

    if (!use_linear_blending) {
        rgba = unlinearize(rgba);
    }

    rgba.rgb *= vec3(rgba.a);

    out_FragColor = rgba;
}
