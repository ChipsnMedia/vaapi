
import sys
import os
import filecmp
FNI_STREAM_NAME_IDX = 0
FNI_VA_STREAM_NAME_IDX = 1
FNI_OUTPUT_FILE_VAAPI_FFMPEG = 2 # decoded by ffmpeg 
FNI_OUTPUT_FILE_CMODEL = 3 # decoded by c-model using es stream
FNI_OUTPUT_FILE_VAAPI_CMODEL = 4 # decoded by vaapi c-model using va bitstream for CNM internel
FNI_OUTPUT_FILE_VAAPI_APP = 5 # decoded by test app on fpga using va bitstream for CNM internel
FNI_TRACE_FILE_FROM_LIBVA = 6 # trace file from libva

TC_COMPARE_VAAPI_FFMPEG_AND_REFC = 0
TC_COMPARE_REFC_AND_VAAPI_REFC = 1 # for CNM internel 
TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC = 2 # for CNM internel
MY_LIBVA_DRIVERS_PATH = "/usr/lib/x86_64-linux-gnu/dri"
STABLE_LIBVA_DRIVERS_PATH = "/home/ta1-ubuntu/Users/jeff/vaapi/media-driver/build/media_driver"
MY_LIBVA_DRIVER_NAME = "iHD"
FFMPEG_FILE_PATH="/usr/local/bin/ffmpeg"
FFMPEG_LOG_LEVEL_STR="verbose" # verbose

FILE_EXT_OF_ELEMENTARY_STREAM = [".264", ".h264", ".hevc", ".h265", ".ivf", ".bin", ".265", ".264", ".jsv", ".bit"]
STREAM_LIST_SKIP_TO_TEST = ["4096x", "3840x", "x4096", "6144x", "Main_8bits_450_HighRes_720x576_r6009"]
BIT_DEPTH = 8
LAST_COMMAND_STR = ""

def set_bit_depth(bit_depth):
    global BIT_DEPTH
    BIT_DEPTH = bit_depth
    return
def get_last_cmdstr():
    return LAST_COMMAND_STR

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
        # if "Dancing_1920x1080p_13mbps_23.97fps_Main_at_4.0L_Cabac_VBR_DTV.mp4" in stream_name:
        #     is_skip = False
        # else:
        #     is_skip = True 
        if is_skip == False:
            test_stream_list.append(stream_name)

    return test_stream_list

def get_file_name_list(stream_name):
    stream_name = os.path.abspath(stream_name)
    print("+" + get_f_name() + " stream_name=" + stream_name)
    file_name_list=["","","","","","","","",""]

    try:
        file_name = os.path.basename(stream_name)
        file_dir = os.path.dirname(stream_name)
        ivf_file_dir = file_dir + "/ivf"
        if os.path.isdir(ivf_file_dir) == False:
            os.mkdir(ivf_file_dir)
        trace_file_from_libva_dir  = ivf_file_dir + "/libva_trace"
        if os.path.isdir(trace_file_from_libva_dir) == False:
            os.mkdir(trace_file_from_libva_dir)
    
        yuv_file_dir = file_dir + "/yuv"
        if os.path.isdir(yuv_file_dir) == False:
            os.mkdir(yuv_file_dir)

    except Exception as e:
        print("+" + get_f_name() + " Exception str=" + str(e))
        pass

    va_stream_name = ivf_file_dir + "/" + file_name + ".ivf" 
    trace_file_from_libva = trace_file_from_libva_dir + "/" + file_name + ".trace.txt" 
    output_file_ffmpeg = yuv_file_dir + "/" + file_name + ".vaapi.ffmpeg.yuv" 
    output_file_cmodel = yuv_file_dir + "/" + file_name + ".cmodel.yuv" 
    output_file_vaapi_cmodel = yuv_file_dir + "/" + file_name + ".vaapi.cmodel.yuv" 
    output_file_vaapi_app = yuv_file_dir + "/" + file_name + ".vaapi.app.yuv" 

    file_name_list[FNI_STREAM_NAME_IDX] = stream_name
    file_name_list[FNI_VA_STREAM_NAME_IDX] = va_stream_name
    file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG] = output_file_ffmpeg
    file_name_list[FNI_OUTPUT_FILE_CMODEL] = output_file_cmodel
    file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL] = output_file_vaapi_cmodel
    file_name_list[FNI_OUTPUT_FILE_VAAPI_APP] = output_file_vaapi_app
    file_name_list[FNI_TRACE_FILE_FROM_LIBVA] = trace_file_from_libva
    print("-" + get_f_name())
    print(file_name_list)
    return  file_name_list


def decode_vaapi_ffmpeg(file_name_list, enable_to_generate_va_bistream):

    ret = False 
    fmt_str = ""
    stream_name = file_name_list[FNI_STREAM_NAME_IDX]
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    trace_file_name = file_name_list[FNI_TRACE_FILE_FROM_LIBVA]
    output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG]
        
    os.putenv("LIBVA_DRIVERS_PATH", MY_LIBVA_DRIVERS_PATH)
    os.system("echo $LIBVA_DRIVERS_PATH")

    os.putenv("LIBVA_DRIVER_NAME", MY_LIBVA_DRIVER_NAME)
    os.putenv("LIBVA_TRACE", trace_file_name)
    os.system("echo $LIBVA_TRACE")
    os.putenv("LIBVA_VA_BITSTREAM", va_stream_name)
    os.system("echo $LIBVA_VA_BITSTREAM")
    if enable_to_generate_va_bistream == True:
        os.putenv("LIBVA_DRIVERS_PATH", STABLE_LIBVA_DRIVERS_PATH)
        # os.putenv("LIBVA_VA_BITSTREAM", va_stream_name)
        # os.system("echo $LIBVA_VA_BITSTREAM")
    if BIT_DEPTH == 8:
        fmt_str = "yuv420p"
    else:
        fmt_str = "yuv420p10le"

    cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_flags allow_profile_mismatch -i " + stream_name + " -f rawvideo -pix_fmt " + fmt_str + " -vsync passthrough -autoscale 0 -y " + output_name
    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True

        if ret == True:
            if enable_to_generate_va_bistream == True:
                if os.path.isfile(va_stream_name) == False:
                    print(get_f_name() + "va_stream is not generated, " + va_stream_name)
                    ret = False
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    global LAST_COMMAND_STR
    LAST_COMMAND_STR = cmdstr
    print(get_f_name() + "result is " + str(ret))
    return ret

def decode_cnm_vaapi_app(vaapi_app_path, codec_str, file_name_list):

    ret = False
    wtl_fmt_str = "--wtl-format=0"
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_APP]

    if BIT_DEPTH == 8:
        wtl_fmt_str = "--wtl-format=0"
    else:
        wtl_fmt_str = "--wtl-format=6" # LSB

    if "avc_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=0 --input=" + va_stream_name + " --output=" + output_name 
    elif "hevc_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=12 --input=" + va_stream_name + " --output=" + output_name 
    elif "vp9_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=13 --input=" + va_stream_name + " --output=" + output_name 
    elif "vp8_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=11 --input=" + va_stream_name + " --output=" + output_name 
    elif "vc1_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=1 --input=" + va_stream_name + " --output=" + output_name 
    elif "mpeg2_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=2 --input=" + va_stream_name + " --output=" + output_name 
    elif "mpeg4_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=3 --input=" + va_stream_name + " --output=" + output_name 
    elif "h263_dec" in codec_str:
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=4 --input=" + va_stream_name + " --output=" + output_name 
    else: # av1
        cmdstr = vaapi_app_path + " " + wtl_fmt_str + " --codec=16 --input=" + va_stream_name + " --output=" + output_name 

    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    global LAST_COMMAND_STR
    LAST_COMMAND_STR = cmdstr
    print(get_f_name() + "result is " + str(ret))
    return ret

def decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, enable_vaapi, enable_display_order):
    ret = False
    output_format = "0"
    is_es_stream = False
    stream_name = file_name_list[FNI_STREAM_NAME_IDX]
    stream_name_ext = os.path.splitext(stream_name)[1]
    stream_name_ext = stream_name_ext.lower()
    va_stream_name = file_name_list[FNI_VA_STREAM_NAME_IDX]
    if enable_vaapi:
        output_name = file_name_list[FNI_OUTPUT_FILE_VAAPI_CMODEL]
    else:
        output_name = file_name_list[FNI_OUTPUT_FILE_CMODEL]


    if "vp8_dec" in codec_str or "vc1_dec" in codec_str or "mpeg2_dec" in codec_str  or "mpeg4_dec" in codec_str or "h263_dec" in codec_str :
        print(get_f_name() + " not supported codec_str : " + str(codec_str))
        return True

    if enable_vaapi == False:

        is_es_stream = False
        for es_stream_ext in FILE_EXT_OF_ELEMENTARY_STREAM:
            if es_stream_ext in stream_name_ext:
                is_es_stream = True
                break

        if is_es_stream == True:
            es_stream_name = stream_name
            print(get_f_name() + "skip to make es file = " + stream_name)
        else:
            try:

                file_name = os.path.basename(stream_name)
                file_dir = os.path.dirname(stream_name)

                es_file_dir = file_dir + "/es"
                if os.path.isdir(es_file_dir) == False:
                    os.mkdir(es_file_dir)

                es_stream_name = es_file_dir + "/" + file_name + ".es" 
                if stream_name.find(".mp4") == -1:
                    if "avc_dec" in codec_str:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy -f h264 " + es_stream_name + " -y"
                    elif "hevc_dec" in codec_str:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy -f hevc " + es_stream_name + " -y"
                    elif "av1_dec" in codec_str or "vp9_dec" in codec_str:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy -f ivf " + es_stream_name + " -y"
                    else:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy " + es_stream_name + " -y"
                else:
                    if "avc_dec" in codec_str:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy -f h264 -vbsf h264_mp4toannexb " + es_stream_name + " -y"
                    elif "hevc_dec" in codec_str:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy -f hevc -vbsf hevc_mp4toannexb " + es_stream_name + " -y"
                    else:
                        cmdstr = FFMPEG_FILE_PATH + " -loglevel " + FFMPEG_LOG_LEVEL_STR + " -i " + stream_name + " -vcodec copy " + es_stream_name + " -y"
                       

                print(get_f_name() + "make es file cmd = " + cmdstr)
                # disable HW acceleration
                os.putenv("LIBVA_DRIVERS_PATH", "")
                os.putenv("LIBVA_DRIVER_NAME", "")

                if os.system(cmdstr) == 0:
                    ret = True

            except Exception as e:
                print(get_f_name() + " Exception str=" + str(e))
                pass

    ret = False
    if BIT_DEPTH == 8:
        output_format = "0"
    else:
        output_format = "5" # LSB

    if enable_vaapi == True:
        cmdstr = refc_file_path + " -y " + output_format + " --codec " + codec_str + " --vaapi -c -i " + va_stream_name + " -o " + output_name 
    else:
        if enable_display_order == False:
            if "av1_dec" in codec_str:
                cmdstr = refc_file_path + " -y " + output_format + " --ivf -r -c --codec " + codec_str + " -i " + es_stream_name + " -o "  + output_name
            elif "vp9_dec" in codec_str:
                cmdstr = refc_file_path + " -y " + output_format + " --ivf -r -c --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name
            else:
                cmdstr = refc_file_path + " -y " + output_format + " -r -c --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name
        else:
            if "av1_dec" in codec_str:
                cmdstr = refc_file_path + " -y " + output_format + " --ivf --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name 
            elif "vp9_dec" in codec_str:
                cmdstr = refc_file_path + " -y " + output_format + " --ivf --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name 
            else:
                cmdstr = refc_file_path + " -y " + output_format + " --codec " + codec_str + " -i " + es_stream_name + " -o " + output_name 

    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass
    global LAST_COMMAND_STR
    LAST_COMMAND_STR = cmdstr
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
    elif test_case == TC_COMPARE_VAAPI_FFMPEG_AND_REFC:
        golden = file_name_list[FNI_OUTPUT_FILE_CMODEL]
        compare = file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG]
    else:
        print(get_f_name() + " no test case")
        return ret

    try:
        ret = filecmp.cmp(golden, compare)
    except Exception as e:
        print("compare_output Exception str=" + str(e))
        pass

    if ret == False:
        print(get_f_name() + "MISMATCH golden : " + golden + " and compare : " + compare)
    else:
        print(get_f_name() + "MATCH golden : " + golden + " and compare : " + compare)


    return ret

def execute_libvautils():
    ret = False
    os.putenv("LIBVA_DRIVERS_PATH", MY_LIBVA_DRIVERS_PATH)
    os.system("echo $LIBVA_DRIVERS_PATH")
    os.putenv("LIBVA_DRIVER_NAME", MY_LIBVA_DRIVER_NAME) 
        
    cmdstr = "test_va_api"
       
    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True

    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    print(get_f_name() + "result is " + str(ret))
    return ret

def execute_vaapifits():
    ret = False
    os.putenv("LIBVA_DRIVERS_PATH", MY_LIBVA_DRIVERS_PATH)
    os.system("echo $LIBVA_DRIVERS_PATH")
    os.putenv("LIBVA_DRIVER_NAME", MY_LIBVA_DRIVER_NAME) 

    os.putenv("GST_VAAPI_ALL_DRIVERS", "1") 
    os.putenv("VAAPI_FITS_CONFIG_FILE", "./config/vpu") 
    # os.putenv("GST_DEBUG", "2") 
    # os.putenv("LIBVA_MESSAGING_LEVEL", "2") 
    # os.system("echo $GST_PLUGIN_PATH")

    org_path = os.path.abspath("./")
    try:
        cmdstr = "gst-inspect-1.0 vaapi"
        print(get_f_name() + " " + cmdstr)
        os.system(cmdstr)
    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    abs_path = os.path.abspath("../vaapi-fits")
    os.chdir(abs_path)

    cmdstr = "./vaapi-fits run test/gst-vaapi/decode --platform KBL --call-timeout 6000000"
       
    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True

    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    print(get_f_name() + "result is " + str(ret))

    cmdstr = "./vaapi-fits run test/ffmpeg-vaapi/decode --platform KBL --call-timeout 6000000"
       
    print(get_f_name() + " " + cmdstr)
    try:
        if os.system(cmdstr) == 0:
            ret = True

    except Exception as e:
        print(get_f_name() + " Exception str=" + str(e))
        pass

    os.chdir(org_path)
    print(get_f_name() + "result is " + str(ret))
    return ret
