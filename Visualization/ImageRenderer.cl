__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void renderToTexture(
        __read_only image2d_t image,
        __write_only image2d_t texture,
        __private float level,
        __private float window
        ) {
    const int x = get_global_id(0);
    const int y = get_global_id(1);

    // TODO type and components support

    float value = (read_imageui(image, sampler, (int2)(x,y)).x - level + window*0.5f) / window;
    value = clamp(value, 0.0f, 1.0f);
    //printf("value: %f\n", value);
    write_imagef(texture, (int2)(x,get_global_size(1)-y-1), (float4)(value,value,value,1.0));
}