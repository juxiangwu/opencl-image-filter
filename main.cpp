#include <iostream>
#include <fileutils.h>
#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <CL/cl.h>
#include "fileutils.h"
#include <math.h>

using namespace std;

int main(int argc,char * argv[])
{
    if(argc < 3){
        std::cout << "usage:" << argv[0] << " <image> <kernel name>" << std::endl;
        return -1;
    }
    const char * imageFile = argv[1];
//    const char * imageFile2 = argv[2];

    const char * kernelFile = "kernels/filters.cl";
    cv::Mat src = cv::imread(imageFile);
//    cv::Mat src2 = cv::imread(imageFile2);
    cv::cvtColor(src,src,CV_BGR2RGBA);
//    cv::cvtColor(src2,src2,CV_BGR2BGRA);

    cv::Mat dst(src.size(),src.type());
//    src.convertTo(dst,src.type());
    std::string source;
    if(FileUtils::loadSource(kernelFile,source) < 0){
        std::cerr << "load kernel faile.\n";
        return -1;
    }

    /*Step1: Getting platforms and choose an available one.*/
    cl_uint numPlatforms;	//the NO. of platforms
    cl_platform_id platform = NULL;	//the chosen platform
    cl_int	status = clGetPlatformIDs(0, NULL, &numPlatforms);
    if (status != CL_SUCCESS)
    {
        cout << "Error: Getting platforms!" << endl;
        return -1;
    }

    /*For clarity, choose the first available platform. */
    if(numPlatforms > 0)
    {
        cl_platform_id* platforms = (cl_platform_id* )malloc(numPlatforms* sizeof(cl_platform_id));
        status = clGetPlatformIDs(numPlatforms, platforms, NULL);
        platform = platforms[0];
        free(platforms);
    }

    /*Step 2:Query the platform and choose the first GPU device if has one.Otherwise use the CPU as device.*/
    cl_uint				numDevices = 0;
    cl_device_id        *devices;
    status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 0, NULL, &numDevices);
    if (numDevices == 0)	//no GPU available.
    {
        cout << "No GPU device available." << endl;
        cout << "Choose CPU as default device." << endl;
        status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, 0, NULL, &numDevices);
        devices = (cl_device_id*)malloc(numDevices * sizeof(cl_device_id));
        status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, numDevices, devices, NULL);
    }
    else
    {
        devices = (cl_device_id*)malloc(numDevices * sizeof(cl_device_id));
        status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, numDevices, devices, NULL);
    }


    /*Step 3: Create context.*/
    cl_context context = clCreateContext(NULL,1, devices,NULL,NULL,NULL);

    if(context == NULL){
        std::cerr << "cannot create context.\n";
        return -1;
    }

    /*Step 4: Creating command queue associate with the context.*/
    cl_command_queue commandQueue = clCreateCommandQueue(context, devices[0], 0, NULL);
    if(commandQueue == NULL){
        std::cerr << "cannot create command queue.\n";
        return -1;
    }
    const char *csource = source.c_str();
    size_t sourceSize[] = {strlen(csource)};
    cl_program program = clCreateProgramWithSource(context, 1, &csource, sourceSize, NULL);

    status=clBuildProgram(program, 1,devices,NULL,NULL,NULL);
    if(status != CL_SUCCESS){
        std::cout << "build program error.\n";
        size_t logLen = 0;
        clGetProgramBuildInfo(program,devices[0],CL_PROGRAM_BUILD_LOG,0,NULL,&logLen);
        char * info = new char[logLen];
        clGetProgramBuildInfo(program,devices[0],CL_PROGRAM_BUILD_LOG,logLen,info,NULL);
        std::cout << "error:\n";
        std::cout << info << std::endl;
        delete[]info;
        return -1;
    }

    int imgsize = src.cols * src.rows * src.channels();
    uchar * buffer = new uchar[imgsize];
    memcpy(buffer,src.data,imgsize);
    cl_image_format imgformat;

    imgformat.image_channel_data_type = CL_UNORM_INT8;
    imgformat.image_channel_order = CL_RGBA;

    cl_mem imgsrc = clCreateImage2D(context,CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                    &imgformat,src.cols,src.rows,0,buffer,&status);

    if(status != CL_SUCCESS){
        std::cerr << "cannot create image buffer:" << status << std::endl;
        return -1;
    }

    delete [] buffer;
//    uchar * buffer2 = new uchar[imgsize];
//    memcpy(buffer2,src2.data,imgsize);

//    cl_mem imgsrc2 = clCreateImage2D(context,CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
//                                    &imgformat,src2.cols,src2.rows,0,buffer2,&status);

//    delete [] buffer2;

    if(status != CL_SUCCESS){
        std::cerr << "cannot create image buffer2:" << status << std::endl;
        return -1;
    }

    cl_mem imgdst = clCreateImage2D(context,CL_MEM_WRITE_ONLY,&imgformat,src.cols,src.rows,0,NULL,&status);
    if(status != CL_SUCCESS){
        std::cerr << "cannot create image dst buffer:" << status << std::endl;
        return -1;
    }

    int mask_width = 3;
    int mask_height = 3;
    const float average_mask[9] = {1 / 9.0f,1 / 9.0f,1 / 9.0f,
                                    1 / 9.0f,1 / 9.0f,1 / 9.0f,
                                    1 / 9.0f,1 / 9.0f,1 / 9.0f};

     cl_mem maskbuffer = clCreateBuffer(context,CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,9 * sizeof(float),(void *)&average_mask,&status);

     if(status != CL_SUCCESS){
         std::cerr << "create mask buffer failed.\n";
         return -1;
     }

    //cl_kernel kernel = clCreateKernel(program,"sepia_filter2",&status);
    cl_kernel kernel = clCreateKernel(program,argv[2],&status);

    if(status != CL_SUCCESS){
        std::cerr << "cannot create kernel:" << status << std::endl;
        return -1;
    }


    status = clSetKernelArg(kernel,0,sizeof(cl_mem),&imgsrc);
//    status = clSetKernelArg(kernel,1,sizeof(cl_mem),&imgsrc2);
    status |= clSetKernelArg(kernel,1,sizeof(cl_mem),&imgdst);
//    status |= clSetKernelArg(kernel,2,sizeof(int),&mask_width);
//    status |= clSetKernelArg(kernel,3,sizeof(int),&mask_height);
//    status |= clSetKernelArg(kernel,4,sizeof(cl_mem),&maskbuffer);
    if(status != CL_SUCCESS){
        std::cerr << "cannot set kernel arg:" << status << std::endl;
        return -1;
    }

    std::cout << "start run...\n";

    size_t origin [3] = {0,0,0};
    size_t region [3] = {src.cols,src.rows,1};

    size_t localWorkSize[2] = {8,8};
    size_t globalWorkSize[2] = {src.cols,src.rows};

    size_t globalsize = src.cols * src.rows;
//    status = clEnqueueNDRangeKernel(commandQueue,kernel,2,NULL,globalWorkSize,localWorkSize,0,NULL,NULL);
//    status = clEnqueueNDRangeKernel(commandQueue,kernel,2,NULL,globalWorkSize,NULL,0,NULL,NULL);

    size_t locals[2] = {8,8};
    size_t globals[2];
    globals[0] = (src.cols + locals[0] - 1) / locals[0];
    globals[1] = (src.rows + locals[1] - 1) / locals[1];

    globals[0] *= locals[0];
    globals[1] *= locals[1];

    status = clEnqueueNDRangeKernel(commandQueue,kernel,2,NULL,globals,locals,0,NULL,NULL);

    if(status != CL_SUCCESS){
        std::cerr << "cannot execute clEnqueueNDRangeKernel:" << status << std::endl;
        return -1;
    }
    uchar * dstdata = dst.data;
    status = clEnqueueReadImage(commandQueue,imgdst,CL_TRUE,origin,region,0,0,dstdata,0,NULL,NULL);

    if(status != CL_SUCCESS){
        std::cerr << "cannot execute clEnqueueReadImage:" << status << std::endl;
        return -1;
    }

    //cv::add(dst,src,dst);
    cv::cvtColor(src,src,CV_RGBA2BGRA);
    cv::cvtColor(dst,dst,CV_RGBA2BGRA);

    cv::imshow("src",src);
    cv::imshow("dst",dst);


    cv::waitKey();

    clReleaseCommandQueue(commandQueue);
    clReleaseProgram(program);
    clReleaseKernel(kernel);

    clReleaseContext(context);
    clReleaseMemObject(imgsrc);
//    clReleaseMemObject(imgsrc2);
//    delete [] buffer;
//    delete [] buffer2;
    clReleaseMemObject(imgdst);
    clReleaseMemObject(maskbuffer);

    return 0;
}

