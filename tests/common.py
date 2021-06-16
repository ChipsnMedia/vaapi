
import sys
import os
import filecmp

FNI_STREAM_NAME_IDX = 0
FNI_VA_STREAM_NAME_IDX = 1
FNI_OUTPUT_FILE_VAAPI_FFMPEG = 2 # decoded by ffmpeg without cnm vaapi driver(the default vaapi driver)
FNI_OUTPUT_FILE_CNM_VAAPI_FFMPEG = 3 # decoded by ffmpeg with cnm vaapi driver 
FNI_OUTPUT_FILE_CMODEL = 4 # decoded by c-model using es stream
FNI_OUTPUT_FILE_VAAPI_CMODEL = 5 # decoded by vaapi c-model using va bitstream
FNI_OUTPUT_FILE_VAAPI_APP = 6 # decoded by test app on fpga using va bitstream
FNI_TRACE_FILE_FROM_LIBVA = 7 # trace file from libva

TC_COMPARE_REFC_AND_VAAPI_REFC = 0
TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC = 1
TC_COMPARE_VAAPI_FFMPEG_AND_CNM_VAAPI_FFMPEG = 2

FFMPEG_FILE_PATH="/usr/local/bin/ffmpeg"

STREAM_LIST_SKIP_TO_TEST = ["4096x", "3840x", "x4096", "6144x"]

def get_f_name():
    return "[" + sys._getframe().f_back.f_code.co_name + "] "


def get_bitstream_list(path, stream_list):
    list_of_folders = os.listdir(path)
    # print(get_f_name() + list_of_folders)
    for f in list_of_folders:
        file_path = path + "/" + f
        if os.path.isdir(file_path) == True:
            print("no getting a file in subfolders=" + file_path)
            # no getting a file in subfolders
            # get_bitstream_list(file_path, stream_list)
        else:
            stream_list.append(file_path)
    return


def get_test_stream_list(stream_root):
    bitstream_list = []
    test_stream_list = []
    is_skip = False
    # stream_param = ()

    get_bitstream_list(stream_root, bitstream_list)
    for stream_name in bitstream_list: 
        is_skip = False
        for skip_stream_name in STREAM_LIST_SKIP_TO_TEST:
            if skip_stream_name in stream_name:
                is_skip = True
                break
        if is_skip == False:
            test_stream_list.append(stream_name)

    return test_stream_list

def get_file_name_list(stream_name):
    print("+" + get_f_name() + " ret=" + stream_name)
    file_name_list=["","","","","","","","",""]
    file_name = os.path.basename(stream_name)
    file_dir = os.path.dirname(stream_name)
    ivf_file_dir = file_dir + "/ivf"
    if os.path.isdir(ivf_file_dir) == False:
        os.mkdir(ivf_file_dir)
    va_stream_name = ivf_file_dir + "/" + file_name + ".ivf" 
    trace_file_from_libva = ivf_file_dir + "/" + file_name + ".trace.txt" 
    
    yuv_file_dir = file_dir + "/yuv"
    if os.path.isdir(yuv_file_dir) == False:
        os.mkdir(yuv_file_dir)
    output_file_ffmpeg = yuv_file_dir + "/" + file_name + ".vaapi.ffmpeg.yuv" 
    output_file_vaapi_ffmpeg = yuv_file_dir + "/" + file_name + ".cnm_vaapi.ffmpeg.yuv" 
    output_file_cmodel = yuv_file_dir + "/" + file_name + ".cmodel.yuv" 
    output_file_vaapi_cmodel = yuv_file_dir + "/" + file_name + ".vaapi.cmodel.yuv" 
    output_file_vaapi_app = yuv_file_dir + "/" + file_name + ".vaapi.app.yuv" 

    file_name_list[FNI_STREAM_NAME_IDX] = stream_name
    file_name_list[FNI_VA_STREAM_NAME_IDX] = va_stream_name
    file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG] = output_file_ffmpeg
    file_name_list[FNI_OUTPUT_FILE_CNM_VAAPI_FFMPEG] = output_file_vaapi_ffmpeg
    file_name_list[FNI_OUTPUT_FILE_CMODEL] = output_file_cmodel
    file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL] = output_file_vaapi_cmodel
    file_name_list[FNI_OUTPUT_FILE_VAAPI_APP] = output_file_vaapi_app
    file_name_list[FNI_TRACE_FILE_FROM_LIBVA] = trace_file_from_libva
    print("-" + get_f_name())
    print(file_name_list)
    return  file_name_list

def decode_vaapi_app(file_name_list, enable_vaapi):

    ret = False 
    stream_name = file_name_list[FNI_STREAM_NAME_IDX]
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_APP]

    # os.putenv("LIBVA_DRIVERS_PATH", "/usr/lib/x86_64-linux-gnu/dri") os.system("echo $LIBVA_DRIVERS_PATH")

    # os.putenv("LIBVA_DRIVER_NAME", "iHD")
    # os.system("echo $LIBVA_DRIVER_NAME")

    # os.putenv("LIBVA_TRACE", "./result/va_trace.txt")
    # os.system("echo $LIBVA_TRACE")

    # os.putenv("LIBVA_VA_BITSTREAM", va_stream_name)
    # os.system("echo $LIBVA_VA_BITSTREAM")

    # cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i " + stream_name + " -f rawvideo -pix_fmt yuv420p " + output_name + " -y"
    # # cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -f rawvideo -pix_fmt yuv420p " + output_name + " -y"
    # print("bf." + cmdstr + ", result is" + str(ret))
    # try:

    #     if os.system(cmdstr) == 0:
    #         ret = True
    # except Exception as e:
    #     print("decode_vaapi_ffmpeg Exception str=" + str(e))
    #     pass
    # print("af." + cmdstr + ", result is" + str(ret))
    return ret

def decode_vaapi_ffmpeg(file_name_list, enable_load_cnm_driver, enable_to_generate_va_bistream):

    ret = False 
    stream_name = file_name_list[FNI_STREAM_NAME_IDX]
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    trace_file_name = file_name_list[FNI_TRACE_FILE_FROM_LIBVA]
    if enable_load_cnm_driver == True:
        output_name = file_name_list[FNI_OUTPUT_FILE_CNM_VAAPI_FFMPEG]
    else:
        output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG]
        
    os.putenv("LIBVA_DRIVERS_PATH", "/usr/lib/x86_64-linux-gnu/dri")
    os.system("echo $LIBVA_DRIVERS_PATH")

    if enable_load_cnm_driver == True:
        os.putenv("LIBVA_DRIVER_NAME", "iVPU")
    else:
        os.putenv("LIBVA_DRIVER_NAME", "iHD")
    os.putenv("LIBVA_TRACE", trace_file_name)
    os.system("echo $LIBVA_TRACE")
    if enable_to_generate_va_bistream == True:
	    os.putenv("LIBVA_VA_BITSTREAM", va_stream_name)
	    os.system("echo $LIBVA_VA_BITSTREAM")
        
    cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i " + stream_name + " -f rawvideo -pix_fmt yuv420p " + output_name + " -y"
       
    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    print(get_f_name() + "result is " + str(ret))
    return ret

def decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, enable_vaapi):
    ret = False
    stream_name = file_name_list[FNI_STREAM_NAME_IDX]
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    if enable_vaapi:
        output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL]
    else:
        output_name = file_name_list[FNI_OUTPUT_FILE_CMODEL]

    try:

        file_name = os.path.basename(stream_name)
        file_dir = os.path.dirname(stream_name)

        es_file_dir = file_dir + "/es"
        if os.path.isdir(es_file_dir) == False:
            os.mkdir(es_file_dir)

        es_stream_name = es_file_dir + "/" + file_name + ".es" 
        if stream_name.find(".mp4") == -1:
            cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -vcodec copy -f h264 " + es_stream_name + " -y"
        else:
            cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -vcodec copy -f h264 -vbsf h264_mp4toannexb " + es_stream_name + " -y"

        print(get_f_name() + "make es file cmd = " + cmdstr)
        if os.system(cmdstr) == 0:
            ret = True

    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    ret = False

    if enable_vaapi == True:
        cmdstr = refc_file_path + " --codec " + codec_str + " --vaapi -i " + va_stream_name + " -o " + output_name 
    else:
        cmdstr = refc_file_path + " -r -c --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name 

    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    print(get_f_name() + "result is " + str(ret))
    return ret

def compare_output(file_name_list, test_case):
    ret = False
    if test_case == TC_COMPARE_REFC_AND_VAAPI_REFC: 
        golden = file_name_list[FNI_OUTPUT_FILE_CMODEL]
        compare = file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL]
    elif test_case == TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC:
        golden = file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL]
        compare = file_name_list[FNI_OUTPUT_FILE_VAAPI_APP]
    elif test_case == TC_COMPARE_VAAPI_FFMPEG_AND_CNM_VAAPI_FFMPEG:
        golden = file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL]
        compare = file_name_list[FNI_OUTPUT_FILE_CNM_VAAPI_FFMPEG]
    else:
        print(get_f_name() + " no test case")
        return ret

    try:
        ret = filecmp.cmp(golden, compare)
    except Exception as e:
        print("compare_output Exception str=" + str(e))
        pass
    return ret
