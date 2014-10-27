#define PI_F 3.14159265358979323846f

void filter2d_internal(__read_only image2d_t input,
                       __write_only image2d_t output,
                       const int maskWidth,
                       const int maskHeight,
                        float * mask,int compute_aver);

__kernel void gray(__read_only image2d_t input, __write_only image2d_t output){

    const sampler_t sampler = CLK_FILTER_NEAREST |
                          CLK_NORMALIZED_COORDS_FALSE |
                          CLK_ADDRESS_CLAMP_TO_EDGE;

    int2 size = get_image_dim(input);
    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float4 pixel = (float4)(0,0,0,1);

    if(coord.x >= size.x || coord.y >= size.y){
        return;
    }


    pixel = read_imagef(input,sampler,coord);
    pixel.x = pixel.y = pixel.z = (pixel.x + pixel.y + pixel.z) / 3.0f;

    write_imagef(output,coord,pixel);
}

__kernel void sharpen(__read_only image2d_t input,__write_only image2d_t output){
    const int sharpen_mask [9] = {-0,-2,0,-2,9,-2,0,-2,0};
    const sampler_t sampler = CLK_FILTER_NEAREST |
                          CLK_NORMALIZED_COORDS_FALSE |
                          CLK_ADDRESS_CLAMP_TO_EDGE;

    int2 size = get_image_dim(input);
    int2 coord = (int2)(get_global_id(0),get_global_id(1));


    float4 color = (float4)(0,0,0,1);


    int2 c00 = (int2)(coord.x - 1,coord.y - 1);
    int2 c01 = (int2)(coord.x,coord.y - 1);
    int2 c02 = (int2)(coord.x + 1,coord.y - 1);

    int2 c10 = (int2)(coord.x - 1,coord.y );
    int2 c11 = (int2)(coord.x,coord.y);
    int2 c12 = (int2)(coord.x + 1,coord.y);

    int2 c20 = (int2)(coord.x - 1,coord.y + 1);
    int2 c21 = (int2)(coord.x,coord.y + 1);
    int2 c22 = (int2)(coord.x + 1,coord.y + 1);

    float4 p00 = read_imagef(input,sampler,c00);
    float4 p01 = read_imagef(input,sampler,c01);
    float4 p02 = read_imagef(input,sampler,c02);

    float4 p10 = read_imagef(input,sampler,c10);
    float4 p11 = read_imagef(input,sampler,c11);
    float4 p12 = read_imagef(input,sampler,c12);

    float4 p20 = read_imagef(input,sampler,c20);
    float4 p21 = read_imagef(input,sampler,c21);
    float4 p22 = read_imagef(input,sampler,c22);

    color.x = p00.x * sharpen_mask[0] +
              p01.x * sharpen_mask[1] +
              p02.x * sharpen_mask[2] +
              p10.x * sharpen_mask[3] +
              p11.x * sharpen_mask[4] +
              p12.x * sharpen_mask[5] +
              p20.x * sharpen_mask[6] +
              p21.x * sharpen_mask[7] +
              p22.x * sharpen_mask[8] ;


   color.y =  p00.y * sharpen_mask[0] +
              p01.y * sharpen_mask[1] +
              p02.y * sharpen_mask[2] +
              p10.y * sharpen_mask[3] +
              p11.y * sharpen_mask[4] +
              p12.y * sharpen_mask[5] +
              p20.y * sharpen_mask[6] +
              p21.y * sharpen_mask[7] +
              p22.y * sharpen_mask[8] ;


   color.z =  p00.z * sharpen_mask[0] +
              p01.z * sharpen_mask[1] +
              p02.z * sharpen_mask[2] +
              p10.z * sharpen_mask[3] +
              p11.z * sharpen_mask[4] +
              p12.z * sharpen_mask[5] +
              p20.z * sharpen_mask[6] +
              p21.z * sharpen_mask[7] +
              p22.z * sharpen_mask[8] ;


   write_imagef(output,coord,color);
}

__kernel void gaussian(__read_only image2d_t input, __write_only image2d_t output){

    const int gaussian_mask[9] = {1,2,1,2,4,2,1,2,1};
    const sampler_t sampler = CLK_FILTER_NEAREST |
                          CLK_NORMALIZED_COORDS_FALSE |
                          CLK_ADDRESS_CLAMP_TO_EDGE;

    int2 size = get_image_dim(input);
    int2 coord = (int2)(get_global_id(0),get_global_id(1));


    float4 color = (float4)(0,0,0,1);


    int2 c00 = (int2)(coord.x - 1,coord.y - 1);
    int2 c01 = (int2)(coord.x,coord.y - 1);
    int2 c02 = (int2)(coord.x + 1,coord.y - 1);

    int2 c10 = (int2)(coord.x - 1,coord.y );
    int2 c11 = (int2)(coord.x,coord.y);
    int2 c12 = (int2)(coord.x + 1,coord.y);

    int2 c20 = (int2)(coord.x - 1,coord.y + 1);
    int2 c21 = (int2)(coord.x,coord.y + 1);
    int2 c22 = (int2)(coord.x + 1,coord.y + 1);

    float4 p00 = read_imagef(input,sampler,c00);
    float4 p01 = read_imagef(input,sampler,c01);
    float4 p02 = read_imagef(input,sampler,c02);

    float4 p10 = read_imagef(input,sampler,c10);
    float4 p11 = read_imagef(input,sampler,c11);
    float4 p12 = read_imagef(input,sampler,c12);

    float4 p20 = read_imagef(input,sampler,c20);
    float4 p21 = read_imagef(input,sampler,c21);
    float4 p22 = read_imagef(input,sampler,c22);

    color.x = p00.x * gaussian_mask[0] +
              p01.x * gaussian_mask[1] +
              p02.x * gaussian_mask[2] +
              p10.x * gaussian_mask[3] +
              p11.x * gaussian_mask[4] +
              p12.x * gaussian_mask[5] +
              p20.x * gaussian_mask[6] +
              p21.x * gaussian_mask[7] +
              p22.x * gaussian_mask[8] ;


    color.y = p00.y * gaussian_mask[0] +
              p01.y * gaussian_mask[1] +
              p02.y * gaussian_mask[2] +
              p10.y * gaussian_mask[3] +
              p11.y * gaussian_mask[4] +
              p12.y * gaussian_mask[5] +
              p20.y * gaussian_mask[6] +
              p21.y * gaussian_mask[7] +
              p22.y * gaussian_mask[8] ;


    color.z = p00.z * gaussian_mask[0] +
              p01.z * gaussian_mask[1] +
              p02.z * gaussian_mask[2] +
              p10.z * gaussian_mask[3] +
              p11.z * gaussian_mask[4] +
              p12.z * gaussian_mask[5] +
              p20.z * gaussian_mask[6] +
              p21.z * gaussian_mask[7] +
              p22.z * gaussian_mask[8] ;

    float div = 16.0f;

    color.x = color.x / div;
    color.y = color.y / div;
    color.z = color.z / div;


    write_imagef(output,coord,color);
}


__kernel void filter_average(__read_only image2d_t input, __write_only image2d_t output){
    const int average_mask[9] = {1,1,1,1,1,1,1,1,1};
    const sampler_t sampler = CLK_FILTER_NEAREST |
                          CLK_NORMALIZED_COORDS_FALSE |
                          CLK_ADDRESS_CLAMP_TO_EDGE;

    int2 size = get_image_dim(input);
    int2 coord = (int2)(get_global_id(0),get_global_id(1));


    float4 color = (float4)(0,0,0,1);


    int2 c00 = (int2)(coord.x - 1,coord.y - 1);
    int2 c01 = (int2)(coord.x,coord.y - 1);
    int2 c02 = (int2)(coord.x + 1,coord.y - 1);

    int2 c10 = (int2)(coord.x - 1,coord.y );
    int2 c11 = (int2)(coord.x,coord.y);
    int2 c12 = (int2)(coord.x + 1,coord.y);

    int2 c20 = (int2)(coord.x - 1,coord.y + 1);
    int2 c21 = (int2)(coord.x,coord.y + 1);
    int2 c22 = (int2)(coord.x + 1,coord.y + 1);

    float4 p00 = read_imagef(input,sampler,c00);
    float4 p01 = read_imagef(input,sampler,c01);
    float4 p02 = read_imagef(input,sampler,c02);

    float4 p10 = read_imagef(input,sampler,c10);
    float4 p11 = read_imagef(input,sampler,c11);
    float4 p12 = read_imagef(input,sampler,c12);

    float4 p20 = read_imagef(input,sampler,c20);
    float4 p21 = read_imagef(input,sampler,c21);
    float4 p22 = read_imagef(input,sampler,c22);

    color.x = p00.x * average_mask[0] +
              p01.x * average_mask[1] +
              p02.x * average_mask[2] +
              p10.x * average_mask[3] +
              p11.x * average_mask[4] +
              p12.x * average_mask[5] +
              p20.x * average_mask[6] +
              p21.x * average_mask[7] +
              p22.x * average_mask[8] ;


    color.y = p00.y * average_mask[0] +
              p01.y * average_mask[1] +
              p02.y * average_mask[2] +
              p10.y * average_mask[3] +
              p11.y * average_mask[4] +
              p12.y * average_mask[5] +
              p20.y * average_mask[6] +
              p21.y * average_mask[7] +
              p22.y * average_mask[8] ;


    color.z = p00.z * average_mask[0] +
              p01.z * average_mask[1] +
              p02.z * average_mask[2] +
              p10.z * average_mask[3] +
              p11.z * average_mask[4] +
              p12.z * average_mask[5] +
              p20.z * average_mask[6] +
              p21.z * average_mask[7] +
              p22.z * average_mask[8] ;

    float div = 9.0f;

    color.x = color.x / div;
    color.y = color.y / div;
    color.z = color.z / div;


    write_imagef(output,coord,color);
}

__kernel void filter_laplace(__read_only image2d_t input, __write_only image2d_t output){
    const int laplace_mask[9] = {1,1,1,1,-8,1,1,1,1};
    const sampler_t sampler = CLK_FILTER_NEAREST |
                          CLK_NORMALIZED_COORDS_FALSE |
                          CLK_ADDRESS_CLAMP_TO_EDGE;

    int2 size = get_image_dim(input);
    int2 coord = (int2)(get_global_id(0),get_global_id(1));


    float4 color = (float4)(0,0,0,1);


    int2 c00 = (int2)(coord.x - 1,coord.y - 1);
    int2 c01 = (int2)(coord.x,coord.y - 1);
    int2 c02 = (int2)(coord.x + 1,coord.y - 1);

    int2 c10 = (int2)(coord.x - 1,coord.y );
    int2 c11 = (int2)(coord.x,coord.y);
    int2 c12 = (int2)(coord.x + 1,coord.y);

    int2 c20 = (int2)(coord.x - 1,coord.y + 1);
    int2 c21 = (int2)(coord.x,coord.y + 1);
    int2 c22 = (int2)(coord.x + 1,coord.y + 1);

    float4 p00 = read_imagef(input,sampler,c00);
    float4 p01 = read_imagef(input,sampler,c01);
    float4 p02 = read_imagef(input,sampler,c02);

    float4 p10 = read_imagef(input,sampler,c10);
    float4 p11 = read_imagef(input,sampler,c11);
    float4 p12 = read_imagef(input,sampler,c12);

    float4 p20 = read_imagef(input,sampler,c20);
    float4 p21 = read_imagef(input,sampler,c21);
    float4 p22 = read_imagef(input,sampler,c22);

    color.x = p00.x * laplace_mask[0] +
              p01.x * laplace_mask[1] +
              p02.x * laplace_mask[2] +
              p10.x * laplace_mask[3] +
              p11.x * laplace_mask[4] +
              p12.x * laplace_mask[5] +
              p20.x * laplace_mask[6] +
              p21.x * laplace_mask[7] +
              p22.x * laplace_mask[8] ;


    color.y = p00.y * laplace_mask[0] +
              p01.y * laplace_mask[1] +
              p02.y * laplace_mask[2] +
              p10.y * laplace_mask[3] +
              p11.y * laplace_mask[4] +
              p12.y * laplace_mask[5] +
              p20.y * laplace_mask[6] +
              p21.y * laplace_mask[7] +
              p22.y * laplace_mask[8] ;


    color.z = p00.z * laplace_mask[0] +
              p01.z * laplace_mask[1] +
              p02.z * laplace_mask[2] +
              p10.z * laplace_mask[3] +
              p11.z * laplace_mask[4] +
              p12.z * laplace_mask[5] +
              p20.z * laplace_mask[6] +
              p21.z * laplace_mask[7] +
              p22.z * laplace_mask[8] ;

//    float div = 9.0f;

//    color.x = color.x / div;
//    color.y = color.y / div;
//    color.z = color.z / div;


    write_imagef(output,coord,color);
}

__kernel void prewitt(__read_only image2d_t input, __write_only image2d_t output){

    const int prewitt_mask_h [9] = {1,1,1,0,0,0,-1,-1,-1};
    const int prewitt_mask_v [9] = {-1,0,1,-1,0,1,-1,0,1};

    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

     int2 coord = (int2)(get_global_id(0),get_global_id(1));
     const int maskSize = 3;
     const int maskrows = maskSize / 2;
     const int maskcols = maskSize / 2;

     float4 color = (float4)(0,0,0,1);
     float4 colorv = (float4)(0,0,0,1);
     float4 colorh = (float4)(0,0,0,1);

     int mask_idx = 0;
     for(int y = -maskrows;y <= maskrows;++y){

         for(int x = -maskcols; x <= maskcols;++x){
             float4 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y));

             colorh.x += srcColor.x * prewitt_mask_h[mask_idx];
             colorh.y += srcColor.y * prewitt_mask_h[mask_idx];
             colorh.z += srcColor.z * prewitt_mask_h[mask_idx];

             colorv.x += srcColor.x * prewitt_mask_v[mask_idx];
             colorv.y += srcColor.y * prewitt_mask_v[mask_idx];
             colorv.z += srcColor.z * prewitt_mask_v[mask_idx];

             color.x = colorh.x > colorv.x ? colorh.x : colorv.x;
             color.y = colorh.y > colorv.y ? colorh.y : colorv.y;
             color.z = colorh.z > colorv.z ? colorh.z : colorv.z;

//             color.x = colorh.x + colorv.x;
//             color.y = colorh.y + colorv.y;
//             color.z = colorh.z + colorv.z;

             mask_idx += 1;
         }
     }

     write_imagef(output,coord,color);
}

__kernel void kirsch(__read_only image2d_t input, __write_only image2d_t output){


    const int kirsh_mask_1[3][3] = {{5,5,5},{-3,0,-3},{-3,-3,-3}};
    const int kirsh_mask_2[3][3] = {{-3,5,5},{-3,0,5},{-3,-3,-3}};
    const int kirsh_mask_3[3][3] = {{-3,-3,5},{-3,0,5},{-3,-3,5}};
    const int kirsh_mask_4[3][3] = {{-3,-3,-3},{-3,0,5},{-3,5,5}};
    const int kirsh_mask_5[3][3] = {{-3,-3,-3},{-3,0,-3},{5,5,5}};
    const int kirsh_mask_6[3][3] = {{-3,-3,-3},{5,0,-3},{5,5,-3}};
    const int kirsh_mask_7[3][3] = {{5,-3,-3},{5,0,-3},{5,-3,-3}};
    const int kirsh_mask_8[3][3] = {{5,5,-3},{5,0,-3},{-3,-3,-3}};


    const sampler_t sampler = CLK_FILTER_NEAREST |
                         CLK_NORMALIZED_COORDS_FALSE |
                         CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    const int maskwidth = 3;
    const int maskheight = 3;
    const int maskrows = maskwidth / 2;
    const int maskcols = maskheight / 2;
    float3 sum[8] = {(float3)(0,0,0)};
    float4 color = (float4)(0,0,0,1);
    int maskIdx = 0;
    for(int y = 0;y <= maskrows;y++){
       for(int x = 0; x <= maskcols;x++){
            float4 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y));

            sum[0].x +=  srcColor.x * kirsh_mask_1[x][y];
            sum[0].y +=  srcColor.y * kirsh_mask_1[x][y];
            sum[0].z +=  srcColor.z * kirsh_mask_1[x][y];

            sum[1].x +=  srcColor.x * kirsh_mask_2[x][y];
            sum[1].y +=  srcColor.y * kirsh_mask_2[x][y];
            sum[1].z +=  srcColor.z * kirsh_mask_2[x][y];

            sum[2].x +=  srcColor.x * kirsh_mask_3[x][y];
            sum[2].y +=  srcColor.y * kirsh_mask_3[x][y];
            sum[2].z +=  srcColor.z * kirsh_mask_3[x][y];

            sum[3].x +=  srcColor.x * kirsh_mask_4[x][y];
            sum[3].y +=  srcColor.y * kirsh_mask_4[x][y];
            sum[3].z +=  srcColor.z * kirsh_mask_4[x][y];

            sum[4].x +=  srcColor.x * kirsh_mask_5[x][y];
            sum[4].y +=  srcColor.y * kirsh_mask_5[x][y];
            sum[4].z +=  srcColor.z * kirsh_mask_5[x][y];

            sum[5].x +=  srcColor.x * kirsh_mask_6[x][y];
            sum[5].y +=  srcColor.y * kirsh_mask_6[x][y];
            sum[5].z +=  srcColor.z * kirsh_mask_6[x][y];

            sum[6].x +=  srcColor.x * kirsh_mask_7[x][y];
            sum[6].y +=  srcColor.y * kirsh_mask_7[x][y];
            sum[6].z +=  srcColor.z * kirsh_mask_7[x][y];

            sum[7].x +=  srcColor.x * kirsh_mask_8[x][y];
            sum[7].y +=  srcColor.y * kirsh_mask_8[x][y];
            sum[7].z +=  srcColor.z * kirsh_mask_8[x][y];

            maskIdx += 1;
         }
     }



    for(int i = 0;i < 8;i++){

        float maxX = 0;
        float maxY = 0;
        float maxZ = 0;
        if(maxX < sum[i].x)maxX = sum[i].x;

        if(maxX < 0) maxX = 0;

        if(maxX > 1) maxX = 1;

        if(maxY < sum[i].y)maxX = sum[i].y;

        if(maxY < 0) maxY = 0;

        if(maxY > 1) maxY = 1;

        if(maxZ < sum[i].z)maxX = sum[i].z;

        if(maxZ < 0) maxZ = 0;

        if(maxZ > 1) maxZ = 1;

        color.x = maxX;
        color.y = maxY;
        color.z = maxZ;
    }



    write_imagef(output,coord,color);

}

__kernel void filter2d(__read_only image2d_t input,
                       __write_only image2d_t output,
                       const int maskWidth,
                       const int maskHeight,
                       __global float * mask){

   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));

   const int maskrows = maskWidth / 2;
   const int maskcols = maskHeight / 2;

   float4 color = (float4)(0,0,0,1);
   int idx = 0;

   for(int y = -maskrows;y <= maskrows;++y){
      for(int x = -maskcols; x <= maskcols;++x){
        float4 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y));
        color.x += srcColor.x * mask[idx];
        color.y += srcColor.y * mask[idx];
        color.z += srcColor.z * mask[idx];
        idx++;
      }
   }
  write_imagef(output,coord,color);
}

__kernel void selection_gray_filter(__read_only image2d_t input,
                                    __write_only image2d_t output){

}

__kernel void gamma_correction(__read_only image2d_t input,
                               __write_only image2d_t output){
     const sampler_t sampler = CLK_FILTER_NEAREST |
                               CLK_NORMALIZED_COORDS_FALSE |
                               CLK_ADDRESS_CLAMP_TO_EDGE;

     const int2 size = get_image_dim(input);

     int2 coord = (int2)(get_global_id(0),get_global_id(1));
    /*
     float4 color = (float4)(0,0,0,1);
     float gamma = 2.2f;
     float lut[256] = {0};
     for(int i = 0;i < 256;i++){
        float val = pow(i / 255.0f,gamma);
        lut[i] = val;
     }

     float4 srcColor = read_imagef(input,sampler,coord);
     color.x = srcColor.x * lut[convert_uchar_sat(srcColor.x * 255.0f)];
     color.y = srcColor.y * lut[convert_uchar_sat(srcColor.y * 255.0f)];
     color.z = srcColor.z * lut[convert_uchar_sat(srcColor.z * 255.0f)];

     write_imagef(output,coord,color);
    */
     float gamma = 2.0f;
     float3 srcRGB = read_imagef(input,sampler,coord).xyz;
     float3 dstRGB = pow(srcRGB,(float3)(1.0f / gamma,1.0f / gamma,1.0f / gamma));
     
     write_imagef(output,coord,(float4)(dstRGB,1.0f));
     
}

__kernel void median_filter(__read_only image2d_t input,
                               __write_only image2d_t output){

}

__kernel void rgb2hsi(__read_only image2d_t input,
                               __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float4 color = (float4)(0,0,0,1);

    float r,g,b,num,den,dim,minVal,theta,H,S,I;

    float4 srcColor = read_imagef(input,sampler,coord);

    b = srcColor.x;
    g = srcColor.y;
    r = srcColor.z;

    num = 0.5 * ((r - g) + (r - b));
    den = sqrt((r - g) * (r - g) + (r - b) * (g - b));

    if(den == 0) {
        H = 0;
    }else{
        theta = acos(num / den);
        if(b > g){
            H = (2 * 3.14159265358979323846f - theta) / (2 * 3.14159265358979323846f);
        }else{
            H = theta / (2 * 3.14159265358979323846f);
        }
    }

    minVal = (b > g) ? g : b;
    minVal = (minVal > r) ? r : minVal;

    den = r + g + b;
    if(den == 0){
        S = 0;
    }else{
        S = 1 - 3 * minVal / den;
    }

    I = (r + g + b) / 3;

    color.x = H;
    color.y = S;
    color.z = I;

    write_imagef(output,coord,color);
}


__kernel void log_filter(__read_only image2d_t input,
                               __write_only image2d_t output){
     const sampler_t sampler = CLK_FILTER_NEAREST |
                               CLK_NORMALIZED_COORDS_FALSE |
                               CLK_ADDRESS_CLAMP_TO_EDGE;

     const int2 size = get_image_dim(input);

     int2 coord = (int2)(get_global_id(0),get_global_id(1));

     float4 color;

     float4 srcColor = read_imagef(input,sampler,coord);

     float3 logval = log(1.0f + srcColor.xyz);
     float scale = 2.0f;
     color = scale * (float4)(logval,1.0f);

     write_imagef(output,coord,color);
}


__kernel void contrast_filter(__read_only image2d_t input,
                               __write_only image2d_t output){
     const sampler_t sampler = CLK_FILTER_NEAREST |
                               CLK_NORMALIZED_COORDS_FALSE |
                               CLK_ADDRESS_CLAMP_TO_EDGE;

     const int2 size = get_image_dim(input);

     int2 coord = (int2)(get_global_id(0),get_global_id(1));

     float4 color;

     float4 srcColor = read_imagef(input,sampler,coord);
     float scale = -5.0f;
     float3 contrast = (exp(2 * (srcColor.xyz - 0.5f) * scale) - 1) / (exp(2 * (srcColor.xyz - 0.5f) * scale) + 1);

     color = scale * (float4)(contrast,1.0f);

     write_imagef(output,coord,color);
}

__kernel void contrast2_filter(__read_only image2d_t input,
                               __write_only image2d_t output){
     const sampler_t sampler = CLK_FILTER_NEAREST |
                               CLK_NORMALIZED_COORDS_FALSE |
                               CLK_ADDRESS_CLAMP_TO_EDGE;

     const int2 size = get_image_dim(input);

     int2 coord = (int2)(get_global_id(0),get_global_id(1));
     
     float arg = 0.5f;
     float4 color = read_imagef(input,sampler,coord);
     float slope = arg > 0.5f ? 1.0f/(2.0f - 2.0f * arg) : 2.0f * arg;
     float4 dstcolor = (float4)((color.xyz-0.5f)*slope+0.5f, color.w);
     
     write_imagef(output,coord,dstcolor);
}


__kernel void luminace_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float4 color;

    float4 srcColor = read_imagef(input,sampler,coord);

    float gray = srcColor.x * 0.299f + srcColor.y * 0.587f + srcColor.z * 0.114f;

    float thresh = 0.32f;
    
    
    
    if(gray > thresh){
        color = (float4)(mix(srcColor,(float4)(1.0f),0.5f).xyz,1.0f);
    }else{
        color = (float4)((float3)(0.0f),1.0f);    
    }

    write_imagef(output,coord,color);
}

/*
    one dimesional guassian function
*/
float gaussian_dim1d_blur_compute(int i,float sigma){
    float sigmaq = sigma * sigma;
    float value = 0.0f;
    value = exp(-((i * i) / (2.0f * sigmaq))) / sqrt(2.0f * 3.14159265358979323846f * sigmaq);
    return value;
}

__kernel void horizontal_blur_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));

   
    float weight[31] = {0.0f};
    float sum = 0.0f;
    float sigma = 15.0f;
    
    for(int i = 1;i <= 31;i++){
        weight[i - 1] = gaussian_dim1d_blur_compute(i,sigma);
        sum += 2.0f * weight[i - 1];
    }
    
    for(int i = 0;i < 31;i++){
        weight[i] = weight[i] / sum;
    }

    
    float3 dstColor;
    dstColor = read_imagef(input,sampler,coord).xyz * weight[0];
    for(int i = 0;i < 31;i++){
       // if(coord.x != 0){
            int2 offset = (int2)(i ,0);
            dstColor += read_imagef(input,sampler,coord - offset).xyz * weight[i];
            dstColor += read_imagef(input,sampler,coord + offset).xyz * weight[i];
       // }
    }
    
    float4 color = (float4)(dstColor,1.0f);
    
    write_imagef(output,coord,color);
}

__kernel void vertical_blur_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));

   
    float weight[31] = {0.0f};
    float sum = 0.0f;
    float sigma = 15.0f;
    
    for(int i = 1;i <= 31;i++){
        weight[i - 1] = gaussian_dim1d_blur_compute(i,sigma);
        sum += 2.0f * weight[i - 1];
    }
    
    for(int i = 0;i < 31;i++){
        weight[i] = weight[i] / sum;
    }

    
    float3 dstColor;
    dstColor = read_imagef(input,sampler,coord).xyz * weight[0];
    for(int i = 0;i < 31;i++){
       // if(coord.x != 0){
            int2 offset = (int2)(0 ,i);
            dstColor += read_imagef(input,sampler,coord - offset).xyz * weight[i];
            dstColor += read_imagef(input,sampler,coord + offset).xyz * weight[i];
       // }
    }
    
    float4 color = (float4)(dstColor,1.0f);
    
    write_imagef(output,coord,color);
}

__kernel void vert_horiz_blur_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));

   
    float weight[31] = {0.0f};
    float sum = 0.0f;
    float sigma = 15.0f;
    
    for(int i = 1;i <= 31;i++){
        weight[i - 1] = gaussian_dim1d_blur_compute(i,sigma);
        sum += 2.0f * weight[i - 1];
    }
    
    for(int i = 0;i < 31;i++){
        weight[i] = weight[i] / sum;
    }

    
    float3 dstColor;
    dstColor = read_imagef(input,sampler,coord).xyz * weight[0];
    for(int i = 0;i < 31;i++){
       // if(coord.x != 0){
            int2 offset = (int2)(i ,i);
            dstColor += read_imagef(input,sampler,coord - offset).xyz * weight[i];
            dstColor += read_imagef(input,sampler,coord + offset).xyz * weight[i];
       // }
    }
    
    float4 color = (float4)(dstColor,1.0f);
    
    write_imagef(output,coord,color);
}

__kernel void bloom_old(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float3 sum = (float3)(0,0,0);
    
    int mask_width = 4;
    int mask_height = 3;
    
    for(int i = -mask_width;i < mask_width;i++){
        for(int j = -mask_height;j < mask_height;j++){
            sum += read_imagef(input,sampler,coord + (int2)(j,i)).xyz * 0.2f;
        }
    }
    
    float4 srcColor= read_imagef(input,sampler,coord);
    float3 dstRGB;
    if(srcColor.x < 0.3f){
        dstRGB = sum * sum * 0.012f + srcColor.xyz;
    }else{
        if(srcColor.x < 0.5f){
            dstRGB = sum * sum * 0.009f + srcColor.xyz;
        }else{
            dstRGB = sum * sum * 0.0075f + srcColor.xyz;
        }
    }
    
    float4 color = (float4)(dstRGB,1.0f);
    
    write_imagef(output,coord,color);
}

__kernel void bloom_new(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float4 srcColor = read_imagef(input,sampler,coord);
    
    float avg = (srcColor.x + srcColor.y + srcColor.z) / 3.0f;
    
    float3 sum = (float3)(0,0,0);
    
    float mask_width = 5;
    float mask_height = 5;
    
    float bloom_strength = 0.015;
    
    for(int i = -mask_width;i < mask_width; i++){
        for(int j = -mask_height; j < mask_height; j++){
            sum += read_imagef(input,sampler,coord + (int2)(i,j)).xyz * bloom_strength;
        }
    }
    
    float3 dstRGB;
    
    if(avg < 0.025f){
        dstRGB = srcColor.xyz + sum * 0.335f;
    }else if( avg < 0.10f){
        dstRGB = srcColor.xyz + (sum * sum) * 0.5f;
    }else if(avg < 0.88f){
        dstRGB = srcColor.xyz + (sum * sum) * 0.333f;
    }else if(avg >= 0.88f){
        dstRGB = srcColor.xyz + sum;
    }else{
        dstRGB = srcColor.xyz;
    }
    
    write_imagef(output,coord,(float4)(dstRGB,1.0f));
    
}

__kernel void radial_blur(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    int samples[10] = {-8,-5,-3,-2,-1,1,2,3,5,8};
    
    int2 dir = (size / 2) - coord;
    
    float dist = sqrt((float)(dir.x * dir.x) + (float)(dir.y * dir.y));
    
    dir = dir / (int)dist;
    
    float3 sum = (float3)(0,0,0);
    
    float4 srcColor = read_imagef(input,sampler,coord);
    int sampleDist = 2;
    float sampleStrength = 3.2f;
    
    for(int i = 0; i < 10;i++){
        sum += read_imagef(input,sampler,coord + dir * samples[i] * sampleDist).xyz;
    }
    
    sum *= 1.0f / 11.0f;
    
    float t = dist * sampleStrength;
    
    t = clamp(t,0.0f,1.0f);
    
    float3 dstRGB = mix(srcColor.xyz,sum,t);
    
    float4 dstColor = (float4)(dstRGB,1.0f);
    
    write_imagef(output,coord,dstColor);
    
}

__kernel void linearize_depth(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float n = 1.0f; //camera z near
   float f = 100.0f; // camera z far
   
   float4 srcColor = read_imagef(input,sampler,coord);
   
   float z = srcColor.x;
   
   float depth = 1 - (2.0f * n) / (f + n - z * (f - n));
   
   float3 zvec = (float3)(depth,depth,depth);
   
   const float LOG2 = 1.442695f;
   
   float fdistance = 10.0f;
   
   float fogColorStrength = exp2( -fdistance * fdistance * zvec * zvec * LOG2).x;
   
   fogColorStrength = clamp(fogColorStrength,0.0f,1.0f);
   
   float3 fogColor = (float3)(1.0f,1.0f,1.0f);
   
   float3 dstRGB = mix(fogColor,srcColor.xyz, 1 - fogColorStrength);
   
   write_imagef(output,coord,(float4)(dstRGB,1.0f));
   
}

float3 tone_map_filter(float3 hdrRGB,float exposure){
    
    float3 dstRGB = 1.0f - exp2(-hdrRGB * exposure);
    return dstRGB;
    
}


float rand(float2 co){
    float iptr = 1.0f;
    return fract(sin(dot(co.xy,(float2)(12.9898f,78.233f))) * 43758.5453f,&iptr);
}



__kernel void ice_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    float2 v1 = (float2)(0.001f,0.001f);
    float2 v2 = (float2)(0.000f,0.000f);
    float iptr = 1.0f;
    float rnd_scale = 1.0f;
    float2 coordf = (float2)(coord.x,coord.y);
    float rnd_factor = 1.5f;
    float rnd = fract(sin(dot(coordf,v1)) + cos(dot(coordf,v2)) * rnd_scale,&iptr);
    int2 offset = (int2)((int)(rnd * rnd_factor * coord.x),(int)(rnd * rnd_factor * coord.y) );
    float3 srcRGB = read_imagef(input,sampler,offset).xyz;
    
    write_imagef(output,coord,(float4)(srcRGB,1.0f));
    
}

__kernel void protanopia_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
   /*
    float16 protanopia_mask = (float16)(0.20f,0.99f,-0.19f,0.0f,
                                        0.16f,0.79f,0.04f,0.0f,
                                        0.01f,-0.01f,1.00f,0.0f,
                                        0.0f,0.0f,0.0f,1.0f);
                                        */
    float4 protanopia_mask_1 = (float4)(0.20f,0.99f,-0.19f,0.0f);
    float4 protanopia_mask_2 = (float4)(0.16f,0.79f,0.04f,0.0f);
    float4 protanopia_mask_3 = (float4)(0.01f,-0.01f,1.00f,0.0f);
    float4 protanopia_mask_4 = (float4)(0.0f,0.0f,0.0f,1.0f);
    
    float4 protanopia_mask[4] = {protanopia_mask_1,protanopia_mask_2,protanopia_mask_3,protanopia_mask_4};
   
    //float4 v1 = protanopia_mask[0];
    float4 srcRGBA = read_imagef(input,sampler,coord);
    
    float4 dstRGBA;
    float sum[4] = {0.0f};
    for(int i = 0;i < 4;i++){
        
        sum[i] += dot(protanopia_mask[i],srcRGBA);
    }
    
    dstRGBA = (float4)(sum[0],sum[1],sum[2],sum[3]);
    
    write_imagef(output,coord,dstRGBA);
    
   // for(;;);
}

__kernel void reflection_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    float4 p_mat[4];
   
    float4 srcRGBA = read_imagef(input,sampler,coord);
    
    srcRGBA *= M_SQRT2_F / length(srcRGBA);
     
    p_mat[0] = (float4)(1.0f,0.0f,0.0f,0.0f) - (srcRGBA * srcRGBA.x);
    p_mat[1] = (float4)(0.0f,1.0f,0.0f,0.0f) - (srcRGBA * srcRGBA.y);
    p_mat[2] = (float4)(0.0f,0.0f,1.0f,0.0f) - (srcRGBA * srcRGBA.z);
    p_mat[3] = (float4)(0.0f,0.0f,0.0f,1.0f) - (srcRGBA * srcRGBA.w);

    float4 dstRGBA;
    
    float4 x_vec = (float4)(0.5f,0.5f,0.5f,1.0f);
    
    dstRGBA.x = dot(p_mat[0],x_vec);
    dstRGBA.y = dot(p_mat[1],x_vec);
    dstRGBA.z = dot(p_mat[2],x_vec);
    dstRGBA.w = dot(p_mat[3],x_vec);

    write_imagef(output,coord,dstRGBA);
    
}

__kernel void brick_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float3 srcRGB = read_imagef(input,sampler,coord).xyz;
    
    float gray = (srcRGB.x + srcRGB.y + srcRGB.z) / 3;
    
    float thresh = 128.0f / 255.0f;
    
    gray = gray >= thresh ? 255 : 0;
    
    float4 dstRGBA = (float4)(gray,gray,gray,1.0f);
    

    write_imagef(output,coord,dstRGBA);
    
}

__kernel void feather_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
    CLK_NORMALIZED_COORDS_FALSE |
    CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    int width = size.x;
    int height = size.y;
    float ratio = (width > height ? width / height : height / width);
    
    int cx = size.x >> 1;
    int cy = size.y >> 1;
    
    float featherSize = 0.25f;
    int maxval = cx * cx + cy * cy;
    int minval = (int)(maxval * (1 - featherSize));
    
    int diff = maxval - minval;
  
    float3 srcRGB = read_imagef(input,sampler,coord).xyz;
    
    int dx = cx - coord.x;
    int dy = cx - coord.y;
    
    if(size.x > size.y){
        dx = (dx * ratio);
    }else{
        dy = (dy * ratio);
    }
    
    int distSq = dx * dx + dy * dy;
    
    float v = ((float)distSq / diff);
    
    float4 dstRGBA = (float4)((srcRGB + v) ,1.0f);
    

    write_imagef(output,coord,dstRGBA);
    
}


__kernel void scale_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_TRUE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    int width = size.x;
    int height = size.y;
    
    float scale = 0.25f;
    float scalex = 1.0f / (scale * width);
    float scaley = 1.0f / (scale * height);
    
    float2 scale_coord = convert_float2(coord) * (float2)(scalex,scaley);
    
    float4 color = read_imagef(input,sampler,scale_coord);
    
    write_imagef(output,coord,color);
}

__kernel void rotate_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    int width = size.x;
    int height = size.y;
    
    int xc = width / 2;
    int yc = height / 2;
    
    float angle = 45.0f;
    float theta = angle * PI_F / 180.0f;
    
    float xpos = (coord.x - xc) * cos(theta) - (coord.y - yc) * sin(theta) + xc;
    float ypos = (coord.x - xc) * sin(theta) + (coord.y - yc) * cos(theta) + yc;
    
    int2 pos = convert_int2((float2)(xpos,ypos));
    if(pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height){
        float4 color = read_imagef(input,sampler,pos);
    
        write_imagef(output,coord,color);
    }
}

__kernel void add_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
        float4 color = read_imagef(input,sampler,coord) + read_imagef(input2,sampler,coord);
        color.w = 1.0f;

        write_imagef(output,coord,color);
    }
}

__kernel void sub_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);

    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
        float4 color = read_imagef(input,sampler,coord) - read_imagef(input2,sampler,coord);
        color.w = 1.0f;

        write_imagef(output,coord,color);
    }
}



__kernel void add_weighted_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float alpha = 0.45f;
    float beta = 0.55f;
    float gamma = 2.0f;
    
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
        float3 color = read_imagef(input,sampler,coord).xyz * 255.0f * alpha + read_imagef(input2,sampler,coord).xyz * 255.0f * beta + gamma;
        
        color.xyz = color.xyz / 255.0f;
        write_imagef(output,coord,(float4)(color,1.0f));
    }
}

__kernel void xor_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
      
        float3 rgb1 = read_imagef(input,sampler,coord).xyz * 255.0f;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz * 255.0f;
        
        int3 rgbi1 = convert_int3(rgb1);
        int3 rgbi2 = convert_int3(rgb2);
        
        int3 rgb = (rgbi1 ^ rgbi2);
      
        write_imagef(output,coord,(float4)(convert_float3(rgb) / 255.0f,1.0f));
    }
}

__kernel void or_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
      
        float3 rgb1 = read_imagef(input,sampler,coord).xyz * 255.0f;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz * 255.0f;
        
        int3 rgbi1 = convert_int3(rgb1);
        int3 rgbi2 = convert_int3(rgb2);
        
        int3 rgb = (rgbi1 | rgbi2);
      
        write_imagef(output,coord,(float4)(convert_float3(rgb) / 255.0f,1.0f));
    }
}

__kernel void and_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
      
        float3 rgb1 = read_imagef(input,sampler,coord).xyz * 255.0f;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz * 255.0f;
        
        int3 rgbi1 = convert_int3(rgb1);
        int3 rgbi2 = convert_int3(rgb2);
        
        int3 rgb = (rgbi1 & rgbi2);
      
        write_imagef(output,coord,(float4)(convert_float3(rgb) / 255.0f,1.0f));
    }
}

__kernel void multi_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
      
        float3 rgb1 = read_imagef(input,sampler,coord).xyz;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz;
 
        float3 rgb = (rgb1 * rgb2);
      
        write_imagef(output,coord,(float4)(rgb,1.0f));
    }
}

__kernel void div_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
      
        float3 rgb1 = read_imagef(input,sampler,coord).xyz;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz;
   
        float3 rgb = (rgb1 / rgb2);
      
        write_imagef(output,coord,(float4)(rgb,1.0f));
    }
}

__kernel void mix_filter(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
 
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
        float reflection = 0.5f;
        float3 rgb1 = read_imagef(input,sampler,coord).xyz;
        float3 rgb2 = read_imagef(input2,sampler,coord).xyz;
   
        float3 rgb = mix(rgb1,rgb2,reflection);
      
        write_imagef(output,coord,(float4)(rgb,1.0f));
    }
}

__kernel void emboss_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
     
    const int maskrows = 3 / 2;
    const int maskcols = 3 / 2;
    float emboss_mask[9] = {2,0,0,0,-1,0,0,0,-1};
   float3 color = (float3)(0,0,0);
   int idx = 0;
  
    for(int y = -maskrows;y <= maskrows;++y){
      for(int x = -maskcols; x <= maskcols;++x){
        float3 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y)).xyz;
        color += srcColor * emboss_mask[idx];
        idx++;
      }
    }
    
  //  color = color / 3.0f;
  //  color.x = color.y = color.z = (color.x + color.y + color.z) / 3.0f;
 
   write_imagef(output,coord,(float4)(color,1.0f));
    
}

__kernel void mask_blur_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    float2 coordf = convert_float2(coord);
    float3 rgb = read_imagef(input,sampler,coord).xyz;
    int radius = 5;
    float3 color;
    float2 mask_coord;
    int d = (radius * 2 + 1);
    int dsize = d * d;
    
    float mask_kernel [25] = {
        0,0,1,0,0,
        0,1,3,1,0,
        1,3,7,3,1,
        0,1,3,1,0,
        0,0,1,0,0
    };
   
    const int maskrows = radius / 2;
    const int maskcols = radius / 2;
    int idx = 0;
    if(coord.x >= radius && coord.x < width - radius && coord.y >= radius && coord.y < height){
      for(int y = -maskrows;y <= maskrows;++y){
          for(int x = -maskcols; x <= maskcols;++x){
            float3 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y)).xyz * mask_kernel[idx];
            color += srcColor;
            idx++;
          }
        }
    
       color = color / dsize;
    
        write_imagef(output,coord,(float4)(color,0.5f));
    }else{
        write_imagef(output,coord,(float4)(rgb,1.0f));
    }
}


__kernel void color_overlay_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float4 overlay_color = (float4)(0.0f,0.0f,0.5f,0.5f);
    
    
    float4 src_color = read_imagef(input,sampler,coord);
    
    float4 dst_color; //= mix(src_color,overlay_color,1.0f);
   
    dst_color = (float4)(mix(src_color.xyz / max(src_color.w,0.00390625f),overlay_color.xyz / max(overlay_color.w,0.00390625f),overlay_color.w) *  src_color.w,src_color.w);

   
    write_imagef(output,coord,dst_color);
}


__kernel void brighten_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    
    float factor = -0.2f;
    
    float4 color = (float4)(clamp(read_imagef(input,sampler,coord).xyz + factor,0.0f,1.0f),1.0f);
    
    write_imagef(output,coord,color);
}

__kernel void alpha_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float factor = -0.5f;

    float4 color = read_imagef(input,sampler,coord);
    color.w = clamp(factor,0.0f,1.0f);
    write_imagef(output,coord,color);
}

__kernel void saturate_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float factor = -0.5f;
    

    float4 color = read_imagef(input,sampler,coord);
    float gray = (color.x + color.y + color.z) / 3.0f;
    color.x = gray + factor * (color.x - gray);
    color.y = gray + factor * (color.y - gray);
    color.z = gray + factor * (color.z - gray);
    write_imagef(output,coord,color);
}

__kernel void sepia_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float4 rgb = read_imagef(input,sampler,coord);
    
    float r = rgb.x,g = rgb.y,b = rgb.z;
    
    rgb.x = (r * 0.393f) + (g * 0.769f) + (b * 0.189f);
    rgb.y = (r * 0.349f) + (g * 0.686f) + (b * 0.168f);
    rgb.z = (r * 0.272f) + (g * 0.534f) + (b * 0.131f);
    
    
    write_imagef(output,coord,rgb);
}

__kernel void adjust_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_LINEAR |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP_TO_EDGE;

    const int2 size = get_image_dim(input);
    int width = size.x;
    int height = size.y;
    int2 coord = (int2)(get_global_id(0),get_global_id(1));

    float3 rgb = read_imagef(input,sampler,coord).xyz;
    
    float r = 0.0f;
    float g = 0.2f;
    float b = 0.0f;
    
    rgb.x += r;
    rgb.y += g;
    rgb.z += b;
    
    
    write_imagef(output,coord,(float4)(rgb,1.0f));
}

void filter2d_internal(__read_only image2d_t input,
                       __write_only image2d_t output,
                       const int maskWidth,
                       const int maskHeight,
                        float * mask,int compute_aver){

   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));

   const int maskrows = maskWidth / 2;
   const int maskcols = maskHeight / 2;

   float4 color = (float4)(0,0,0,1.0f);
   int idx = 0;

   for(int y = -maskrows;y <= maskrows;++y){
      for(int x = -maskcols; x <= maskcols;++x){
        float4 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y));
          color.xyz += srcColor.xyz * mask[idx];
        idx++;
      }
   }
   if(compute_aver){
     color.xyz = color.xyz / (maskWidth * maskHeight);
   }
  write_imagef(output,coord,color);
}

__kernel void desaturate_luminance_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[25] = {
        0.2764723f, 0.9297080f, 0.0938197f, 0, -37.1f,
	    0.2764723f, 0.9297080f, 0.0938197f, 0, -37.1f,
		0.2764723f, 0.9297080f, 0.0938197f, 0, -37.1f,
		0.0f, 0.0f, 0.0f, 1.0f, 0.0f
    }; 
    int maskWidth = 5;
    int maskHeight = 5;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);
}

__kernel void brownie_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[20] = {
        0.5997023498159715f,0.34553243048391263f,-0.2708298674538042f,0,47.43192855600873f,
	   -0.037703249837783157f,0.8609577587992641f,0.15059552388459913f,0,-36.96841498319127f,
		0.24113635128153335f,-0.07441037908422492f,0.44972182064877153f,0,-7.562075277591283f,
	
    }; 
    int maskWidth = 4;
    int maskHeight = 4;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,1);//ok
    //filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,1);//ok
}

__kernel void sepia2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[9] = {
       0.393f, 0.7689999f, 0.18899999f,
	   0.349f, 0.6859999f, 0.16799999f,
	   0.272f, 0.5339999f, 0.13099999f
	  
    }; 
    int maskWidth = 3;
    int maskHeight = 3;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);//ok
}

__kernel void hue_filter(__read_only image2d_t input,
                         __write_only image2d_t output){
    float angle = 45.0f;
    float rotation = angle / 180.0f * PI_F;
    
    float lumR = 0.213f;
    float lumG = 0.715f;
    float lumB = 0.072f;
    
    
    
    float color_matrix[9] = {
       lumR+cos(rotation)*(1-lumR)+sin(rotation)*(-lumR),lumG+cos(rotation)*(-lumG)+sin(rotation)*(-lumG),lumB+cos(rotation)*(-lumB)+sin(rotation)*(1-lumB),
	   lumR+cos(rotation)*(-lumR)+sin(rotation)*(0.143f),lumG+cos(rotation)*(1-lumG)+sin(rotation)*(0.140f),lumB+cos(rotation)*(-lumB)+sin(rotation)*(-0.283f),
	   lumR+cos(rotation)*(-lumR)+sin(rotation)*(-(1-lumR)),lumG+cos(rotation)*(-lumG)+sin(rotation)*(lumG),lumB+cos(rotation)*(1-lumB)+sin(rotation)*(lumB),
	  
    }; 
    int maskWidth = 3;
    int maskHeight = 3;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);//ok
}

__kernel void hue2_filter(__read_only image2d_t input,
                         __write_only image2d_t output){
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   const float4 kRGBToYPrime = (float4) (0.299, 0.587, 0.114, 0.0);
   const float4 kRGBToI     = (float4) (0.595716, -0.274453, -0.321263, 0.0);    
   const float4 kRGBToQ     = (float4) (0.211456, -0.522591, 0.31135, 0.0);
 
   const float4 kYIQToR   = (float4) (1.0, 0.9563, 0.6210, 0.0);
   const float4 kYIQToG   = (float4) (1.0, -0.2721, -0.6474, 0.0);
   const float4 kYIQToB   = (float4) (1.0, -1.1070, 1.7046, 0.0);
   
   float4 color = read_imagef(input,sampler,coord);
   
   float YPrime  = dot (color, kRGBToYPrime);
   float I      = dot (color, kRGBToI);
   float Q      = dot (color, kRGBToQ);
   
   float hue     = atan2 (Q, I);
   float chroma  = sqrt (I * I + Q * Q);
   
   float hueAdjust = 0.0f;
   
   hue += (-hueAdjust);
   
   Q = chroma * sin (hue);
   I = chroma * cos (hue);
     
     // Convert back to RGB
   float4 yIQ = (float4) (YPrime, I, Q, 0.0);
   color.x = dot (yIQ, kYIQToR);
   color.y = dot (yIQ, kYIQToG);
   color.z = dot (yIQ, kYIQToB);
   
   write_imagef(output,coord,color);
}

__kernel void vintage_pinhole_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[15] = {
            0.6279345635605994f,0.3202183420819367f,-0.03965408211312453f,0,9.3651285835294123f,
			0.02578397704808868f,0.6441188644374771f,0.03259127616149294f,0,7.462829176470591f,
			0.0466055556782719f,-0.0851232987247891f,0.5241648018700465f,0,5.159190588235296f,
			
    }; 
    int maskWidth = 5;
    int maskHeight = 3;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,1);//ok
}

__kernel void techni_color_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[20] = {
            1.9125277891456083f,-0.8545344976951645f,-0.09155508482755585f,0,11.793603434377337f,
			-0.3087833385928097f,1.7658908555458428f,-0.10601743074722245f,0,-70.35205161461398f,
			-0.231103377548616f,-0.7501899197440212f,1.847597816108189f,0,30.950940869491138f,
			0,0,0,1,0
    }; 
    int maskWidth = 5;
    int maskHeight = 4;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,1);//ok,0 also ok
}

__kernel void kodachrome_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[20] = {
           1.1285582396593525f,-0.3967382283601348f,-0.03992559172921793f,0,63.72958762196502f,
			-0.16404339962244616f,1.0835251566291304f,-0.05498805115633132f,0,24.732407896706203f,
			-0.16786010706155763f,-0.5603416277695248f,1.6014850761964943f,0,35.62982807460946f,
			0,0,0,1,0
    }; 
    int maskWidth = 5;
    int maskHeight = 4;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,1);//both
}

__kernel void polariod_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    float color_matrix[20] = {
           1.438f,-0.062f,-0.062f,0,0,
			-0.122f,1.378f,-0.122f,0,0,
			-0.016f,-0.016f,1.483f,0,0,
			0,0,0,1,0
    }; 
    int maskWidth = 5;
    int maskHeight = 4;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);//ok
}

__kernel void prewitt_horizonta_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    float divider = 3.0f;
    float color_matrix[9] = {
           1/divider, 1/divider, 1/divider,
           0, 0, 0,
           -1/divider, -1/divider, -1/divider
    }; 
    int maskWidth = 3;
    int maskHeight = 3;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);//ok
}

__kernel void prewitt_vertical_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    float divider = 3.0f;
    float color_matrix[9] = {
          -1/divider, 0, 1/divider,
          -1/divider, 0, 1/divider,
          -1/divider, 0, 1/divider
    }; 
    int maskWidth = 3;
    int maskHeight = 3;
    
    filter2d_internal(input,output,maskWidth,maskHeight,color_matrix,0);//ok
}

__kernel void posterize2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int level = 255;
   float numAreas = 255.0f / level;
   float numValues = 255.0f / (level - 1);
   
   float3 rgb = clamp((((read_imagef(input,sampler,coord).xyz / numAreas) * numValues) ),0,1.0f);
   
   write_imagef(output,coord,(float4)(rgb,1.0f));
}

__kernel void posterize3_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int level = 1;
   int colors = 40;
   float numAreas = 255.0f / level;
   float numValues = 255.0f / (level - 1);
   
   local float levels[256];
   
   for(int i = 0;i < 256;i++){
       if(i < colors * level){
           levels[i] = colors * (level - 1) / 255.0f;
       }else {
           levels[i] = colors * level / 255.0f;
           ++level;
       }
   }
   
   float3 src_rgb = read_imagef(input,sampler,coord).xyz;
   
   float3 dst_rgb;
   dst_rgb.x = levels[convert_int(src_rgb.x * 255)];
   dst_rgb.y = levels[convert_int(src_rgb.y * 255)];
   dst_rgb.z = levels[convert_int(src_rgb.z * 255)];
   
   write_imagef(output,coord,(float4)(dst_rgb,1.0f));
}

__kernel void solarize_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float amount = 0.25f;
   
   float4 rgb = read_imagef(input,sampler,coord);
   
   if(rgb.x > amount) rgb.x = 1.0 - rgb.x;
   if(rgb.y > amount) rgb.y = 1.0 - rgb.y;
   if(rgb.z > amount) rgb.z = 1.0 - rgb.z;
   
   write_imagef(output,coord,rgb);

}

__kernel void split_red_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float amount = 0.25f;
   
   float4 rgb = read_imagef(input,sampler,coord);
   
   rgb.yz = 0;
   
   write_imagef(output,coord,rgb);

}

__kernel void split_green_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float amount = 0.25f;
   
   float4 rgb = read_imagef(input,sampler,coord);
   
   rgb.xz = 0;
   
   write_imagef(output,coord,rgb);

}

__kernel void split_blue_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
    
    const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float amount = 0.25f;
   
   float4 rgb = read_imagef(input,sampler,coord);
   
   rgb.xy = 0;
   
   write_imagef(output,coord,rgb);

}

__kernel void median2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   float color_mask[25] = {1, 0, 0, 0, 1, 
                         0, 1, 0, 1, 0, 
                         1, 1, 1, 1, 1, 
                         0, 1, 0, 1, 0, 
                         1, 0, 0, 0, 1 }; 
   
   int maskWidth = 5;
   int maskHeight = 5;
 
   filter2d_internal(input,output,maskWidth,maskHeight,color_mask,1);//ok
}

__kernel void pencil_sketch_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
                              
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float3 src_rgb = read_imagef(input,sampler,coord).xyz;
   float3 invert_rgb = 1.0f - src_rgb;
   
   float3 mask [9] = {0.1f, 0.2f, 0.1f, 0.2f, 0.1f, 0.2f, 0.1f, 0.2f, 0.1f};
   
   const int maskrows = 3 / 2;
   const int maskcols = 3 / 2;

   float4 color = (float4)(0,0,0,1.0f);
   int idx = 0;

   for(int y = -maskrows;y <= maskrows;++y){
      for(int x = -maskcols; x <= maskcols;++x){
        float4 srcColor = read_imagef(input,sampler,(int2)(x + coord.x,y + coord.y));
          color.xyz += srcColor.xyz * mask[idx];
        idx++;
      }
   }
   color.xyz = color.xyz / 9;
   
   float3 dst_rgb = clamp(invert_rgb + color.xyz,0,1);
  // dst_rgb.x = dst_rgb.y = dst_rgb.z = (dst_rgb.x + dst_rgb.y + dst_rgb.z) / 3;
   write_imagef(output,coord,(float4)(dst_rgb,1.0f));
}

__kernel void emboss2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   float color_mask[9] = {-2,-1,0,
                          -1,1,1,
                          0,1,2}; 
   
   int maskWidth = 3;
   int maskHeight = 3;
 
   filter2d_internal(input,output,maskWidth,maskHeight,color_mask,1);//both ok
}

__kernel void luminosity_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   float color_mask[9] = {0,0,0,
                          -1,1,-1,
                          0,0,0}; 
   
   int maskWidth = 3;
   int maskHeight = 3;
 
   filter2d_internal(input,output,maskWidth,maskHeight,color_mask,0);
}

float bezier_curve_pow3(float x, float p0, float p1, float p2, float p3){

   //基于三次贝塞尔曲线 
   return p0 * pow((1 - x), 3) + 3 * p1 * x * pow((1 - x), 2) + 3 * p2 * x * x * (1 - x) + p3 * pow(x, 3);
}

float3 calDark(float x, float y, float3 p,float middleX,float middleY,float startDistance,float maxDistance,float lastLevel){
  //计算距中心点距离
  float dist = length((float2)(x - middleX,y - middleY));//distance([x, y], [middleX, middleY]);
  float currBilv = (dist - startDistance) / (maxDistance - startDistance);
  if(currBilv < 0) currBilv = 0;
   //应该增加暗度
    return  bezier_curve_pow3(currBilv, 0, 0.02, 0.3, 1) * p * lastLevel / 255;
  }

__kernel void dark_corner_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int R = 3;//from 1~10
   int lastLevel = 20;//0 ~ 255
   
   int width = size.x;
   int height = size.y;
   
   int lenght = R * 2 + 1;
   
   float middleX = width * 2 / 3;
   float middleY = height * 1/ 2;
   
   float maxDistance = distance(middleX ,middleY);
                //开始产生暗角的距离
   float startDistance = maxDistance * (1 - R / 10);
   
   float4 color = read_imagef(input,sampler,coord);
   
   float3 darkness = calDark(coord.x,coord.y,color.xyz,middleX,middleY,startDistance,maxDistance,lastLevel);
   
   color.xyz -= darkness;
   
   write_imagef(output,coord,color);
   
}

__kernel void oil_paint2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int R = 16;
   int xLength = 2 * R + 1;
   
   float4 color = read_imagef(input,sampler,coord) * 255;
   float gray  = (color.x + color.y + color.z) / 3;
   
   float every = (gray / R) * R;
   
   color.x = color.y = color.z = every;
   
   write_imagef(output,coord,color / 255);
}

float luminance(float4 color){
    const float3 w = (float3)(0.2125, 0.7154, 0.0721);
    return dot(color.xyz, w);
}

__kernel void toon_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 rgb = read_imagef(input,sampler,coord);
   
    float topLeft = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y - 1)));
    // top
    float top = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y - 1)));
    // top right
    float topRight = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y - 1)));
    // left
    float left = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y)));
    // center
    float center = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y)));
    // right
    float right = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y)));
    // bottom left
    float bottomLeft = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y + 1)));
    // bottom
    float bottom = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y + 1)));
    // bottom right
    float bottomRight = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y + 1)));
    
    
    float h = -topLeft-2.0*top-topRight+bottomLeft+2.0*bottom+bottomRight;
    float v = -bottomLeft-2.0*left-topLeft+bottomRight+2.0*right+topRight;

    float mag = length((float2)(h, v));
    float threshold = 0.2f;
    float quantizationLevels = 10;    
    float3 posterizedImageColor = floor((rgb.xyz * quantizationLevels) + 0.5f) / quantizationLevels;
    float thresholdTest = 1.0f - step(threshold, mag);
   
    rgb.xyz = rgb.xyz * thresholdTest;
    
    write_imagef(output,coord,rgb);
}

__kernel void directional_nonmaximum_suppression_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);
   int width = size.x;
   int height = size.y;
   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float upperThreshold = 0.80;
   float lowerThreshold = 0.25;
   
   float4 currentGradientAndDirection = read_imagef(input,sampler,(coord));
   float2 vUv = (float2)(3,3);
   float2 gradientDirection = ((currentGradientAndDirection.yz * 2.0f) - 1.0f) * (float2)(1.0f/width, 1.0f/height);
   float firstSampledGradientMagnitude = read_imagef(input,sampler,convert_int2(gradientDirection + vUv)).x;
   float secondSampledGradientMagnitude = read_imagef(input,sampler,convert_int2(vUv - gradientDirection)).x;
   float multiplier = step(firstSampledGradientMagnitude, currentGradientAndDirection.x);
   multiplier = multiplier * step(secondSampledGradientMagnitude, currentGradientAndDirection.x);
   float thresholdCompliance = smoothstep(lowerThreshold, upperThreshold, currentGradientAndDirection.x);
   multiplier = multiplier * thresholdCompliance;
   
   write_imagef(output,coord,(float4)(multiplier,multiplier,multiplier,1.0f));
}

__kernel void box_blur_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float blurSize =256.0f; 
   float imageWidth = size.x;
   
   float4 sum;
   
   for(int i = 0; i < 40; i++){
      sum += read_imagef(input,sampler, coord + (int2)(0, convert_int((i-20) * blurSize / imageWidth)));
   }
  /*
   for(int i = 0; i < 40; i++){
      sum += read_imagef(input,sampler, coord + (int2)(convert_int((i-20) * blurSize / size.y),0));
   }
   */
   sum = sum / 40;
   
   write_imagef(output,coord,sum);
}


__kernel void color_matrix_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color_matrix = (float4)(1,0.5,0.72,1);
   
   float intensity = 0.8f;
   
   float4 color = read_imagef(input,sampler,coord);
   
   float4 dst_color = color * color_matrix;
   
   dst_color = intensity * dst_color + ( (1.0f-intensity) * color );
   
   write_imagef(output,coord,dst_color);
   
}

__kernel void hexagonal_blur_1(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float blurSize = 256.0f;
   float imageWidth = size.x;
   float imageHeight = size.y;
   
   float2 offset = (float2)(blurSize/imageWidth, blurSize/imageHeight);
   
   float4 color;
   
   for(int i = 0; i < 30; i++){
      color += 1.0f/30.0f * read_imagef(input,sampler, coord + convert_int2((float2)(0.0, offset.y * i)));
   }
   
   write_imagef(output,coord,color);
}

__kernel void hexagonal_blur_2(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float blurSize = 256.0f;
   float imageWidth = size.x;
   float imageHeight = size.y;
   
   float2 offset = (float2)(blurSize/imageWidth, blurSize/imageHeight);
   
   float4 color;
   
   for(int i = 0; i < 30; i++){
      color += 1.0f/30.0f * read_imagef(input,sampler, coord + convert_int2((float2)( offset.x * i, offset.y * i)));
   }
   
   write_imagef(output,coord,color);
}

__kernel void hexagonal_blur_3(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float blurSize = 256.0f;
   float imageWidth = size.x;
   float imageHeight = size.y;
   
   float2 offset = (float2)(blurSize/imageWidth, blurSize/imageHeight);
   
   float4 color2,color1,color3;
   
   for(int i = 0; i < 30; i++){
      color1 += 1.0f/30.0f * read_imagef(input,sampler, coord - convert_int2((float2)( offset.x * i, offset.y * i)));
   }
   
   for(int i = 0; i < 30; i++){
      color2 += 1.0f/30.0f * read_imagef(input,sampler, coord + convert_int2((float2)( offset.x * i, -offset.y * i)));
   }
   
   for(int i = 0; i < 30; i++){
      color3 += 1.0f/30.0f * read_imagef(input,sampler, coord + convert_int2((float2)( offset.x * i, -offset.y * i)));
   }
   
   
   write_imagef(output,coord,(color1 + color2 + color3) / 3);
}

__kernel void sketch_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 rgb = read_imagef(input,sampler,coord);
   
    float topLeft = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y - 1)));
    // top
    float top = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y - 1)));
    // top right
    float topRight = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y - 1)));
    // left
    float left = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y)));
    // center
    float center = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y)));
    // right
    float right = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y)));
    // bottom left
    float bottomLeft = luminance(read_imagef(input,sampler,(int2)(coord.x - 1,coord.y + 1)));
    // bottom
    float bottom = luminance(read_imagef(input,sampler,(int2)(coord.x,coord.y + 1)));
    // bottom right
    float bottomRight = luminance(read_imagef(input,sampler,(int2)(coord.x + 1,coord.y + 1)));
    
    
 
    float h = -topLeft-2.0f*top-topRight+bottomLeft+2.0f*bottom+bottomRight;
	float v = -bottomLeft-2.0f*left-topLeft+bottomRight+2.0f*right+topRight;

	float mag = 1.0f - length((float2)(h, v));

    rgb.x = rgb.y = rgb.z = mag;
    rgb.w = 1.0f;
    
    write_imagef(output,coord,rgb);

}

__kernel void autumn_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   color.x =  color.x + color.y * 1.25f - color.z * 1.25f;
   
   write_imagef(output,coord,color);
}

__kernel void bulge_pinch_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);
   
   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int2 center = (int2)(size.x / 2,size.y / 2);
   
   float2 coord_center = convert_float2(coord - center);
   
   float radius = size.y / 2.0f;
   float strength = 4.0f;
   float dist = length(convert_float2(coord_center));
   
   if (dist < radius) {
         float percent = dist / radius;
         if (strength > 0.0f) {
              coord_center *= mix(1.0f, smoothstep(0.0f, radius / dist, percent), strength * 0.75f);
         } else {
              coord_center *= mix(1.0f, pow(percent, 1.0f + strength * 0.75f) * radius / dist, 1.0f - percent);
         }
    }
    coord_center += convert_float2(center);
   
   float4 color = read_imagef(input,sampler,convert_int2(coord_center));
   
   
   
   write_imagef(output,convert_int2(coord),color);
}

__kernel void swirl_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);
   
   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   int2 center = (int2)(size.x / 2,size.y / 2);
   
   float2 coord_center = convert_float2(coord - center);
   
   float radius = size.y / 2.0f;
   float angle = 5.0f;
   float dist = length(convert_float2(coord_center));
   
   if (dist < radius) {
       
        float percent = (radius - dist) / radius;
            float theta = percent * percent * angle;
            float s = sin(theta);
            float c = cos(theta);
            coord_center = (float2)(
                coord_center.x * c - coord_center.y * s,
                coord_center.x * s + coord_center.y * c);
    }
    coord_center += convert_float2(center);
   
   float4 color = read_imagef(input,sampler,convert_int2(coord_center));
   
   
   
   write_imagef(output,convert_int2(coord),color);
}

__kernel void denoise_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 center_color = read_imagef(input,sampler,coord);
   
   float exponent = 0.5f;
   float strength = 1.0f;
   float total = 0.0f;
   float4 color;
   for (int x = -4; x <= 4; x += 1) {
     for (int y = -4; y <= 4; y += 1) {
           float4 sample = read_imagef(input,sampler, (coord + (int2)(x, y)));
           float dot_res = dot(sample.xyz - center_color.xyz, (float3)(0.25,0.25,0.25));
           float weight = 1.0f - ((dot_res > 0)? dot_res : -dot_res);
           weight = pow(weight, exponent);
           color += sample * weight;
           total += weight;
     }
   }
   
  write_imagef(output,coord,color / total);
}

__kernel void vibrance_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   float amount = 0.5f;
  
   float average = (color.x + color.y + color.z) / 3.0f;
   float mx = max(color.x, max(color.y, color.z));
   float amt = (mx - average) * (-amount * 3.0f);
   color.xyz = mix(color.xyz, (float3)(mx,mx,mx), amt);
   
  write_imagef(output,coord,color);
}



__kernel void brazil_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 src_rgba = read_imagef(input,sampler,coord);
   
   float xBlockSize = 0.01*0.1;
   float yBlockSize = xBlockSize * size.x / size.y;  // mutiply ratio
   float xCoord = (floor((coord.x-0.5)/xBlockSize)+0.5) * xBlockSize+0.5;
   float yCoord = (floor((coord.y-0.5)/yBlockSize)+0.5) * yBlockSize+0.5;
   float arg = 0.5f;
   
   float4 color = read_imagef(input,sampler,convert_int2((float2)(xCoord,yCoord)));
   color = (float4)(color.xyz+arg * 2.0f - 1.0f, color.w);
   
    float sum = (color.x + color.y + color.z) / 3.0f;

    float3 white  = (float3)(255.0f, 255.0f, 255.0f) / 255.0f;
    float3 yellow = (float3)(242.0f, 252.0f,   0.0f) / 255.0f;
    float3 green  = (float3)(  0.0f, 140.0f,   0.0f) / 255.0f;
    float3 brown  = (float3)( 48.0f,  19.0f,   6.0f) / 255.0f;
    float3 black  = (float3)(  0.0f,   0.0f,   0.0f) / 255.0f;

    if      (sum < 0.110f) color = (float4)(black,  color.w);
    else if (sum < 0.310f) color = (float4)(brown,  color.w);
    else if (sum < 0.513f) color = (float4)(green,  color.w);
    else if (sum < 0.965f) color = (float4)(yellow, color.w);
    else                  color = (float4)(white,  color.w);
   
  write_imagef(output,coord,color);
}

float3 gray_internal(float4 color) {
  float y = dot(color.xyz, (float3)(0.2126f, 0.7152f, 0.0722f));
  return (float3)(y,y,y);
}

__kernel void cartoon2_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,convert_float2(coord));
   
   float dx = 1.0f / size.x;
   float dy = 1.0f / size.y;
   
  float3 upperLeft   = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, -dy)));
  float3 upperCenter = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, -dy)));
  float3 upperRight  = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx, -dy)));
  float3 left        = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(-dx, 0.0f)));
  float3 center      = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, 0.0f)));
  float3 right       = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx, 0.0f)));
  float3 lowerLeft   = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(-dx,  dy)));
  float3 lowerCenter = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f,  dy)));
  float3 lowerRight  = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx,  dy)));
  
   // vertical convolution
  //[ -1, 0, 1,
  //  -2, 0, 2,
  //  -1, 0, 1 ]
   float3 vertical  = upperLeft   * -1.0f
                 + upperCenter *  0.0f
                 + upperRight  *  1.0f
                 + left        * -2.0f
                 + center      *  0.0f
                 + right       *  2.0f
                 + lowerLeft   * -1.0f
                 + lowerCenter *  0.0f
                 + lowerRight  *  1.0f;
                 
  // horizontal convolution
  //[ -1, -2, -1,
  //   0,  0,  0,
  //   1,  2,  1 ]
  float3 horizontal = upperLeft   * -1.0f
                  + upperCenter * -2.0f
                  + upperRight  * -1.0f
                  + left        *  0.0f
                  + center      *  0.0f
                  + right       *  0.0f
                  + lowerLeft   *  1.0f
                  + lowerCenter *  2.0f
                  + lowerRight  *  1.0f;
   
   
  float r = (vertical.x > 0 ? vertical.x : -vertical.x) + (horizontal.x > 0 ? horizontal.x : -horizontal.x);
  float g = (vertical.y > 0 ? vertical.x : -vertical.y) + (horizontal.y > 0 ? horizontal.y : -horizontal.y);
  float b = (vertical.z > 0 ? vertical.x : -vertical.z) + (horizontal.z > 0 ? horizontal.z : -horizontal.z);
  if (r > 1.0f) r = 1.0f;
  if (g > 1.0f) g = 1.0f;
  if (b > 1.0f) b = 1.0f;
  
  float4 edged = (float4)(color.xyz - (float3)(r, g, b), color.w);
  
  float arg = 1.0f;
    
   write_imagef(output,coord,(float4)(mix(color.xyz, edged.xyz, arg), color.w));
}

__kernel void croquis_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   float arg = 1.0f;
  
   float dx = 1.0f / size.x;
   float dy = 1.0f / size.y;
   float c  = -1.0f / 8.0f;
   
    
   float r = ((read_imagef(input,sampler, coord + (float2)(-dx, -dy)).x
          +    read_imagef(input,sampler, coord + (float2)(0.0, -dy)).x
          +    read_imagef(input,sampler, coord + (float2)( dx, -dy)).x
          +    read_imagef(input,sampler, coord + (float2)(-dx, 0.0)).x
          +    read_imagef(input,sampler, coord + (float2)( dx, 0.0)).x
          +    read_imagef(input,sampler, coord + (float2)(-dx,  dy)).x
          +    read_imagef(input,sampler, coord + (float2)(0.0,  dy)).x
          +    read_imagef(input,sampler, coord + (float2)( dx,  dy)).x) * c
          +    read_imagef(input,sampler, coord).x) * -2.0f; 
   
    float g = ((read_imagef(input,sampler, coord + (float2)(-dx, -dy)).y
          +   read_imagef(input,sampler, coord+ (float2)(0.0, -dy)).y
          +   read_imagef(input,sampler, coord + (float2)( dx, -dy)).y
          +   read_imagef(input,sampler, coord + (float2)(-dx, 0.0)).y
          +   read_imagef(input,sampler, coord + (float2)( dx, 0.0)).y
          +   read_imagef(input,sampler, coord + (float2)(-dx,  dy)).y
          +   read_imagef(input,sampler, coord + (float2)(0.0,  dy)).y
          +   read_imagef(input,sampler, coord + (float2)( dx,  dy)).y) * c
          +   read_imagef(input,sampler, coord).y) * -24.0;
          
    float b = ((read_imagef(input,sampler, coord + (float2)(-dx, -dy)).z
          +   read_imagef(input,sampler, coord + (float2)(0.0, -dy)).z
          +   read_imagef(input,sampler, coord + (float2)( dx, -dy)).z
          +   read_imagef(input,sampler, coord + (float2)(-dx, 0.0)).z
          +   read_imagef(input,sampler, coord + (float2)( dx, 0.0)).z
          +   read_imagef(input,sampler, coord + (float2)(-dx,  dy)).z
          +   read_imagef(input,sampler, coord + (float2)(0.0,  dy)).z
          +   read_imagef(input,sampler, coord + (float2)( dx,  dy)).z) * c
          +   read_imagef(input,sampler, coord).z) * -24.0;
          
   float brightness = (r * 0.3f + g * 0.59f + b * 0.11f);
   brightness = 1.0f - brightness;
   if (brightness < 0.0f) brightness = 0.0f;
   if (brightness > 1.0f) brightness = 1.0f;
   r = g = b = brightness;  
   
   float3 rgb = (float3)(r, g, b);
   float4 dst_color = (float4)(rgb - (1.0f - arg),1.0f);
   
   write_imagef(output,convert_int2(coord),dst_color);
 
}

__kernel void hardrockcafe_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
    float dx = 1.0f / size.x;
   float dy = 1.0f / size.y;
   
  float3 upperLeft   = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, -dy)));
  float3 upperCenter = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, -dy)));
  float3 upperRight  = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx, -dy)));
  float3 left        = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(-dx, 0.0f)));
  float3 center      = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f, 0.0f)));
  float3 right       = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx, 0.0f)));
  float3 lowerLeft   = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(-dx,  dy)));
  float3 lowerCenter = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)(0.0f,  dy)));
  float3 lowerRight  = gray_internal(read_imagef(input,sampler, convert_float2(coord) + (float2)( dx,  dy)));
  
  // vertical convolution
  //[ -1, 0, 1,
  //  -2, 0, 2,
  //  -1, 0, 1 ]
  float3 vertical  = upperLeft   * -1.0f
                 + upperCenter *  0.0f
                 + upperRight  *  1.0f
                 + left        * -2.0f
                 + center      *  0.0f
                 + right       *  2.0f
                 + lowerLeft   * -1.0f
                 + lowerCenter *  0.0f
                 + lowerRight  *  1.0f;

  // horizontal convolution
  //[ -1, -2, -1,
  //   0,  0,  0,
  //   1,  2,  1 ]
  float3 horizontal = upperLeft   * -1.0f
                  + upperCenter * -2.0f
                  + upperRight  * -1.0f
                  + left        *  0.0f
                  + center      *  0.0f
                  + right       *  0.0f
                  + lowerLeft   *  1.0f
                  + lowerCenter *  2.0f
                  + lowerRight  *  1.0f;


  float v = (vertical.x > 0 ? vertical.x : -vertical.x);
  float h = (horizontal.x > 0 ? horizontal.x : -horizontal.x);
  float m = ( v + h) / 4.0f;
  
  float arg = 0.8f;
  
  float4 dst_color = (float4)(mix(color.xyz, (float3)(v, h, m), arg), color.w);
  
  write_imagef(output,convert_int2(coord),dst_color);
   
}

float4 mangaCool(__read_only image2d_t input,float2 coord,int2 size,float arg){

  const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

  float dx = 1.0f / size.x;
  float dy = 1.0f / size.y;
  float c  = -1.0f / 8.0f; 
  
  
  float r = ((read_imagef(input,sampler, + (float2)(-dx, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).x
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).x
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).x
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).x
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).x) * c
          +    read_imagef(input,sampler,coord).x) * -19.2;

  float g = ((read_imagef(input,sampler,coord + (float2)(-dx, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).y
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).y
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).y
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).y
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).y) * c
          +   read_imagef(input,sampler, coord).y) * -9.6;

  float b = ((read_imagef(input,sampler,coord + (float2)(-dx, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).z
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).z
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).z
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).z
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).z) * c
          +   read_imagef(input,sampler, coord).z) * -4.0;

  if (r < 0.0) r = 0.0;
  if (g < 0.0) g = 0.0;
  if (b < 0.0) b = 0.0;
  if (r > 1.0) r = 1.0;
  if (g > 1.0) g = 1.0;
  if (b > 1.0) b = 1.0;

  float3 rgb = 1.0f - (float3)(r, g, b);
  
  
  float4 cool_color = (float4)(rgb - (arg), 1.0f);
  
  return cool_color;

}

__kernel void hengao_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,convert_int2(coord));
   float arg = 0.75f;
   
   if(arg == 0.5f){
    
     write_imagef(output,convert_int2(coord),color);
   }else if(arg == 1.0f){
       write_imagef(output,convert_int2(coord),(float4)(0,0,0,1));
   }else if(arg > 0.5f){
      int2 coordOffset = size / 2;
      float fd = 500.0 / tan((arg - 0.5f) * PI_F);

      float2 v = coord.xy - convert_float2(coordOffset);
      float d = length(v);
      float2 xy = v / d * fd * tan(clamp(d / fd, -0.5f * PI_F , 0.5f * PI_F )) + convert_float2(coordOffset);
      float2 tc = xy / convert_float2(size);
      if (all(isgreaterequal(tc, (float2)(0.0))) && all(islessequal(tc, (float2)(1.0)))) {
        color = mangaCool(input,coord,size,arg);
      } else {
        color = (float4)(0.0, 0.0, 0.0, 1.0);
      }
      write_imagef(output,convert_int2(coord),color);
   }else{
    int2 coordOffset = size / 2;
    float fd = 500.0 / tan((0.5 - arg) * PI_F);

    int2 v = convert_int2(coord.xy) - coordOffset;
    float d = length(convert_float2(v));
    float2  xy = convert_float2(v) / d * fd * atan(d/fd) + convert_float2(coordOffset);
    color = mangaCool(input,/*xy / convert_float2(size)*/xy,size,arg);
     write_imagef(output,convert_int2(coord),color);
   }
 
}

 float4 brazil_internal(__read_only image2d_t input,
                              float2 coord,int2 size,float arg){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;
   
   float4 src_rgba = read_imagef(input,sampler,coord);
   
   float xBlockSize = 0.01*0.1;
   float yBlockSize = xBlockSize * size.x / size.y;  // mutiply ratio
   float xCoord = (floor((coord.x-0.5)/xBlockSize)+0.5) * xBlockSize+0.5;
   float yCoord = (floor((coord.y-0.5)/yBlockSize)+0.5) * yBlockSize+0.5;
  
   
   float4 color = read_imagef(input,sampler,convert_int2((float2)(xCoord,yCoord)));
   color = (float4)(color.xyz+arg * 2.0f - 1.0f, color.w);
   
    float sum = (color.x + color.y + color.z) / 3.0f;

    float3 white  = (float3)(255.0f, 255.0f, 255.0f) / 255.0f;
    float3 yellow = (float3)(242.0f, 252.0f,   0.0f) / 255.0f;
    float3 green  = (float3)(  0.0f, 140.0f,   0.0f) / 255.0f;
    float3 brown  = (float3)( 48.0f,  19.0f,   6.0f) / 255.0f;
    float3 black  = (float3)(  0.0f,   0.0f,   0.0f) / 255.0f;

    if      (sum < 0.110f) color = (float4)(black,  color.w);
    else if (sum < 0.310f) color = (float4)(brown,  color.w);
    else if (sum < 0.513f) color = (float4)(green,  color.w);
    else if (sum < 0.965f) color = (float4)(yellow, color.w);
    else                  color = (float4)(white,  color.w);
   
   return color;
}


__kernel void hengaoposter_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,convert_int2(coord));
   float arg = 0.7f;
   
    if(arg == 0.5f){
     write_imagef(output,convert_int2(coord),color);
   }else if(arg == 1.0f){
       write_imagef(output,convert_int2(coord),(float4)(0,0,0,1));
   }else if(arg > 0.5f){
    int2 coordOffset = size / 2;
      float fd = 500.0 / tan((arg - 0.5f) * PI_F);

      float2 v = coord.xy - convert_float2(coordOffset);
      float d = length(v);
      float2 xy = v / d * fd * tan(clamp(d / fd, -0.5f * PI_F , 0.5f * PI_F )) + convert_float2(coordOffset);
      float2 tc = xy / convert_float2(size);
      if (all(isgreaterequal(tc, (float2)(0.0))) && all(islessequal(tc, (float2)(1.0)))) {
        color = brazil_internal(input,coord,size,arg);
      } else {
        color = (float4)(0.0, 0.0, 0.0, 1.0);
      }
      write_imagef(output,convert_int2(coord),color);
   }else{
    int2 coordOffset = size / 2;
    float fd = 500.0 / tan((0.5 - arg) * PI_F);

    int2 v = convert_int2(coord.xy) - coordOffset;
    float d = length(convert_float2(v));
    float2  xy = convert_float2(v) / d * fd * atan(d/fd) + convert_float2(coordOffset);
    color = brazil_internal(input,/*xy / convert_float2(size)*/xy,size,arg);
     write_imagef(output,convert_int2(coord),color);
   }
}



__kernel void lego_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,convert_int2(coord));
   
   float arg = 0.75f;
   
   if(arg > 0.0f){
    float xBlockSize = arg * 0.1f;
    float yBlockSize = xBlockSize * size.x / size.y;  // mutiply ratio
    float xCoord = (floor((coord.x - 0.5) / xBlockSize) + 0.5f) * xBlockSize + 0.5f;
    float yCoord = (floor((coord.y - 0.5)/ yBlockSize) + 0.5f) * yBlockSize + 0.5f;
    float4 rgba = read_imagef(input,sampler, convert_int2((float2)(xCoord, yCoord)));
    float sum = (rgba.x + rgba.y + rgba.z) / 3.0f;
    float3 one = (float3)(255.0f, 255.0f, 255.0f) / 255.0f;
    float3 two = (float3)(242.0f, 252.0f, 0.0f) / 255.0f;
    float3 three = (float3)(0.0f, 140.0f, 0.0f) / 255.0f;
    float3 four = (float3)(48.0f, 19.0f, 6.0f) / 255.0f;
    float3 five = (float3)(0.0f, 0.0f, 0.0f) / 255.0f;
/*
黒　緑　黄色　白
1   255 255 255
2   242 252 0
3   0   140 0
4   48  19  6
5   0   0   0
*/
    if      (sum < 0.05){ 
      rgba = (float4)(five,   1.0f);
    }
    else if (sum < 0.65) {
      rgba = (float4)(four,   1.0f);
    }
    else if (sum < 1.40) {
      rgba = (float4)(three, 1.0f);
    }
    else if (sum < 2.15) {
     rgba = (float4)(two,  1.0f);
    }
    else{                 
       rgba = (float4)(one,  1.0f);
    }
   // rgba = color;
    write_imagef(output,convert_int2(coord),rgba);
   }else{
       write_imagef(output,convert_int2(coord),color);
   }
   
}

__kernel void monochrome_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   float arg = 0.75f;
   float4 color = read_imagef(input,sampler,coord);
   float y = dot(color.xyz, (float3)(0.299f, 0.587f, 0.114f));
   float4 dst_color = (float4)(mix(color.xyz, (float3)(y), arg), 1.0f);
   
   write_imagef(output,convert_int2(coord),dst_color);
}

__kernel void monoedge_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   float arg = 0.75f;
   
  float dx = 1.0f / size.x;
  float dy = 1.0f / size.y;
  float c  = -1.0f / 8.0f; 
  
  
  float r = ((read_imagef(input,sampler, + (float2)(-dx, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).x
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).x
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).x
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).x
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).x
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).x) * c
          +    read_imagef(input,sampler,coord).x) * -2;

  float g = ((read_imagef(input,sampler,coord + (float2)(-dx, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).y
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).y
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).y
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).y
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).y
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).y) * c
          +   read_imagef(input,sampler, coord).y) * -24;

  float b = ((read_imagef(input,sampler,coord + (float2)(-dx, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)(0.0, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)( dx, -dy)).z
          +   read_imagef(input,sampler,coord + (float2)(-dx, 0.0)).z
          +   read_imagef(input,sampler,coord + (float2)( dx, 0.0)).z
          +   read_imagef(input,sampler,coord + (float2)(-dx,  dy)).z
          +   read_imagef(input,sampler,coord + (float2)(0.0,  dy)).z
          +   read_imagef(input,sampler,coord + (float2)( dx,  dy)).z) * c
          +   read_imagef(input,sampler, coord).z) * -24.0;

  if (r < 0.0) r = 0.0;
  if (g < 0.0) g = 0.0;
  if (b < 0.0) b = 0.0;
  if (r > 1.0) r = 1.0;
  if (g > 1.0) g = 1.0;
  if (b > 1.0) b = 1.0;
  
  float brightness = (r*0.3 + g*0.59 + b*0.11);
  if (brightness < 0.0) brightness = 0.0;
  if (brightness > 1.0) brightness = 1.0;
  r = g = b = brightness;  

  float3 rgb = (float3)(r, g, b);
  
  
  float4 dst_color = (float4)(rgb - (1.0f - arg), 1.0f);
  
  write_imagef(output,convert_int2(coord),dst_color);
}

__kernel void mosaic_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   float arg = 0.075f;
   float4 color = read_imagef(input,sampler,coord);
   if (arg > 0.0f) {
    float xBlockSize = arg * 0.1f;
    float yBlockSize = xBlockSize * size.x / size.y;  // mutiply ratio
    float xCoord = (floor((coord.x-0.5f)/xBlockSize)+0.5f) * xBlockSize + 0.5f;
    float yCoord = (floor((coord.y-0.5f)/yBlockSize)+0.5f) * yBlockSize + 0.5f;
    float4 rgba = read_imagef(input,sampler,(float2)(xCoord,yCoord));
    write_imagef(output,convert_int2(coord),rgba);
  } else {
    write_imagef(output,convert_int2(coord),color);
  }
   
}


__kernel void polarcoord_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
  float2 coordRect = coord * convert_float2(size);
  float2 center = convert_float2(size) * 0.5f;
  float2 fromCenter = coordRect - center;

  float2 coordPolar = (float2)(
          atan2(fromCenter.x, fromCenter.y) * size.x / (2.0f * PI_F) + center.x,
          length(fromCenter) * 2.0f);
  float4 color;
  float arg = 0.2f;
  float2 tc = mix(coordRect, coordPolar, arg) / convert_float2(size);
   color = read_imagef(input, sampler,tc);
 /* if (all(isgreaterequal(tc, (float2)(0.0))) && all(islessequal(tc, (float2)(1.0)))) {
    color = read_imagef(input, sampler,tc);
  } else {
    color = (float4)(0.0, 0.0, 0.0, 1.0);
  }
  */
  write_imagef(output,convert_int2(coord),color);
}

__kernel void skin_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 size = get_image_dim(input);

   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   
   float4 color = read_imagef(input,sampler,coord);
   
   float r = color.x;
   float g = color.y;
   float b = color.z;
   
   float xy = (r - g);
   xy = xy > 0 ? xy : -xy;
   
   if((r <= 45.0f / 255.0f) || 
      (g <= 40.0f / 255.0f) || 
      (b <= 20.0f / 255.0f) ||
      (r <= g) ||
      (r <= b) ||
      ((r - min(g,b)) <= 15.0f / 255.0f) ||
      (xy <= 15.0f / 255.0f)){
      color.x = color.y = color.z = 0;
   }
   write_imagef(output,convert_int2(coord),color);
}

__kernel void vignette_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 dim = get_image_dim(input);
   
   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float amount = 2.0f;
   float2 vUv = (float2)(100,100);
   
   float dist = distance(vUv,(float2)(dim.x / 2,dim.y / 2));
   
   float4 color = read_imagef(input,sampler,coord);
   float size = 256.0f;
   color.xyz *= smoothstep(0.8f,size * 0.799f,dist * (amount + size));
   
   write_imagef(output,convert_int2(coord),color);
   
}

float lum(float3 color){
    return 0.3f * color.x + 0.59f * color.y + 0.11f * color.z;
}

__kernel void color_clip_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 dim = get_image_dim(input);
   
   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   float L = lum(color.xyz);
   
   float n = min(min(color.x,color.y),color.z);
   float x = max(max(color.x,color.y),color.z);
   
   if(n < 0.0f){
      color.xyz = L +(((color.xyz - L) * L) / (L - n));
   }
   
   if(x > 1.0f){
      color.xyz = L + (((color.xyz - L) * (1 - L)) / (x - L));
   }
   
   color.xyz += (0.5f - L);
   
   write_imagef(output,convert_int2(coord),color);
   
}

__kernel void bias_clip_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 dim = get_image_dim(input);
   
   float2 coord = (float2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);

   float amount = 0.75f;
   
   color.xyz *= clamp(color.xyz / (( 1.0f / amount - 1.9f) * (0.9f - color.xyz) + 1.0f),0.0f,1.0f);
   
   write_imagef(output,convert_int2(coord),color);
}

__kernel void duo_tone_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 dim = get_image_dim(input);
   
   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   float3 dark_color = (float3)(1,1,0);
   float3 light_color = (float3)(0,0,1);
   
   float gray = lum(color.xyz);
   
   float luminance = dot(color.xyz,gray);
   
   color.xyz = clamp(mix(dark_color,light_color,luminance),0.0f,1.0f);
   
   write_imagef(output,coord,color);
   
}

__kernel void opacity_filter(__read_only image2d_t input,
                              __write_only image2d_t output){
   
   const sampler_t sampler = CLK_FILTER_NEAREST |
                             CLK_NORMALIZED_COORDS_FALSE |
                             CLK_ADDRESS_CLAMP_TO_EDGE;

   const int2 dim = get_image_dim(input);
   
   int2 coord = (int2)(get_global_id(0),get_global_id(1));
   
   float4 color = read_imagef(input,sampler,coord);
   
   float opacity_value = 0.5f;
   
   color.w *= opacity_value;
   
   write_imagef(output,coord,color);
   
}