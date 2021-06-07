
import pytest
import sys
import os
import filecmp


REFC_FILE_PATH="/home/ta-ubuntu/Users/gregory/TRY_WAVE517-E_REL_v1.9.9_VAAPI/design/ref_c/bin/Linux/avc_dec"
FFMPEG_FILE_PATH="/home/ta-ubuntu/Users/gregory/ffmpeg/ffmpeg"
STREAM_ROOT = "/Stream/work/gregory/DXVAContent/h264"
def get_bitstream_list(path, stream_list):
    list_of_folders =  os.listdir(path)
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


def get_test_parameter_list():
    bitstream_list = []
    stream_param_list = []
    # stream_param = ()

    get_bitstream_list(STREAM_ROOT, bitstream_list)
    for stream_name in bitstream_list: 
        stream_param_list.append(stream_name)

    return stream_param_list

def get_file_name_list(stream_name):
    print("+get_file_name_list ret=" + stream_name)
    file_name_list=["","","","","",""]
    file_name = os.path.basename(stream_name)
    file_dir = os.path.dirname(stream_name)
    ivf_file_dir = file_dir + "/ivf"
    if os.path.isdir(ivf_file_dir) == False:
        os.mkdir(ivf_file_dir)
    va_stream_name = ivf_file_dir + "/" + file_name + ".ivf" 
    
    yuv_file_dir = file_dir + "/yuv"
    if os.path.isdir(yuv_file_dir) == False:
        os.mkdir(yuv_file_dir)
    output_file_ffmpeg = yuv_file_dir + "/" + file_name + ".ffmpeg.yuv" 
    output_file_cmodel = yuv_file_dir + "/" + file_name + ".cmodel.yuv" 
    output_file_vaapi_cmodel = yuv_file_dir + "/" + file_name + ".vaapi.cmodel.yuv" 
    file_name_list[0] = stream_name
    file_name_list[1] = va_stream_name
    file_name_list[2] = output_file_ffmpeg
    file_name_list[3] = output_file_cmodel
    file_name_list[4] = output_file_vaapi_cmodel
    print("-get_file_name_list ")
    print(file_name_list)
    return  file_name_list

def decode_vaapi_ffmpeg(file_name_list):

    ret = False 
    stream_name = file_name_list[0]
    va_stream_name = file_name_list[1]
    output_name = file_name_list[2]

    os.putenv("LIBVA_DRIVERS_PATH", "/usr/lib/x86_64-linux-gnu/dri")
    os.system("echo $LIBVA_DRIVERS_PATH")

    os.putenv("LIBVA_DRIVER_NAME", "iHD")
    os.system("echo $LIBVA_DRIVER_NAME")

    os.putenv("LIBVA_TRACE", "./result/va_trace.txt")
    os.system("echo $LIBVA_TRACE")

    os.putenv("LIBVA_VA_BITSTREAM", va_stream_name)
    os.system("echo $LIBVA_VA_BITSTREAM")

    cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i " + stream_name + " -f rawvideo -pix_fmt yuv420p " + output_name + " -y"
    # cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -f rawvideo -pix_fmt yuv420p " + output_name + " -y"
    print("bf." + cmdstr + ", result is" + str(ret))
    try:

        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print("decode_vaapi_ffmpeg Exception str=" + str(e))
        pass
    print("af." + cmdstr + ", result is" + str(ret))
    return ret

def decode_cnm_ref_c( file_name_list):
    ret = False
    stream_name = file_name_list[0]
    va_stream_name = file_name_list[1]
    output_name = file_name_list[3]
    try:

        file_name = os.path.basename(stream_name)
        file_dir = os.path.dirname(stream_name)

        es_file_dir = file_dir + "/es"
        if os.path.isdir(es_file_dir) == False:
            os.mkdir(es_file_dir)

        es_stream_name = es_file_dir + "/" + file_name + ".es" 
        if os.path.isfile(es_stream_name) == False:
            if stream_name.find(".mp4") == -1:
                cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -vcodec copy -f h264 " + es_stream_name
            else:
                cmdstr = FFMPEG_FILE_PATH + " -loglevel verbose  -i " + stream_name + " -vcodec copy -f h264 -vbsf h264_mp4toannexb " + es_stream_name

            if os.system(cmdstr) == 0:
                ret = True

        cmdstr = REFC_FILE_PATH + " --codec avc_dec -i " + es_stream_name + " -o " + output_name 
        # cmdstr = REFC_FILE_PATH + " --vaapi --codec avcdec -i " + va_stream_name + " -o " + output_name 
        if os.system(cmdstr) == 0:
            ret = True
    except Exception as e:
        print("decode_cnm_ref_c Exception str=" + str(e))
        pass
    return ret

def compare_output(file_name_list):
    ret = False
    golden = file_name_list[2]
    compare = file_name_list[3]
    try:
        ret = filecmp.cmp(golden, compare)
    except Exception as e:
        print("compare_output Exception str=" + str(e))
        pass
    return ret

@pytest.mark.parametrize("stream_name", get_test_parameter_list())
def test_h264_streams(stream_name):
    ret = False
    print("+test_h264_streams stream_name=" + stream_name)
    # if stream_name.find("AIR_320x240_264") == -1:
    #    pass
    # else:
    file_name_list = get_file_name_list(stream_name)
    decode_vaapi_ffmpeg(file_name_list)
    decode_cnm_ref_c(file_name_list)
    ret = compare_output(file_name_list)
    print("-test_h264_streams ret=" + str(ret))
    assert ret == True


# def main():
#     stream_param_list = get_test_parameter_list()
#     stream_name = ""

#     # stream_param_list just has stream names.
#     for stream_param in stream_param_list: 
#         stream_name = stream_param

#         if stream_name.find("AIR_320x240_264") == -1:
#             continue

#         file_name_list = get_file_name_list(stream_name)
#         decode_vaapi_ffmpeg(file_name_list)
#         decode_cnm_ref_c(file_name_list)
#         ret = compare_output(file_name_list)
#         if ret == True:
#             print("compare ok!!!")
#         else:
#             print("compare fail!!!")

#     return

# if __name__ == '__main__':
#     main()