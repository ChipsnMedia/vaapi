import getopt
from common import*

REFC_FILE_ROOT="../../wave517_dec_pvric_nommf_mthread_v5.5.72_vaapi"

def test_streams(codec_str, input_file_name):
    print("+" + get_f_name() + " input_file_name=" + input_file_name + ",  codec_str=" + codec_str)
    ret = False
    stream_name = input_file_name
    refc_file_path = ""
    if "avc_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/avc_dec"
    elif "hevc_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/hevc_dec"
    elif "av1_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/av1_dec"
    elif "vp9_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/vp9_dec"
    else:
        print("+" + get_f_name() + " unknown codec_str = " + codec_str)
        return False

    file_name_list = get_file_name_list(stream_name)
    if get_refc_test_mode() == True:
        ret = decode_vaapi_ffmpeg(file_name_list, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False

        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c with vaapi mode")
            return False

        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False

        ret = compare_output(file_name_list, TC_COMPARE_REFC_AND_VAAPI_REFC)
        print("-" + get_f_name() + " TC_COMPARE_REFC_AND_VAAPI_REFC ret=" + str(ret))

    else:
        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False

        ret = decode_vaapi_ffmpeg(file_name_list, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False

        ret = compare_output(file_name_list, TC_COMPARE_VAAPI_FFMPEG_AND_REFC)
        print("-" + get_f_name() + " TC_COMPARE_VAAPI_FFMPEG_AND_REFC ret=" + str(ret))


    return ret

def usage():
    print("usage requred")
    return
def main():

    INPUT_FILE = "/Stream/work/gregory/DXVAContent/cnm/AIR_320x240_264.avi"
    CODEC_STR = "avc_dec"
    try:
        opts, args = getopt.getopt(sys.argv[1:],"hc:i:r",["help", "codec=", "input=", "refc_test"])
    except getopt.GetoptError as err:
        print("Error in argument, reason=" + str(err))
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            return
        elif o in ("-c", "--codec"):
            CODEC_STR = a
        elif o in ("-i", "--input"):
            INPUT_FILE = a
            if os.path.isfile(INPUT_FILE) == False:
                print("can't open input file = " + INPUT_FILE)
                return
        elif o in ("-c", "--refc_test"):
            set_refc_test_mode()
        else:
            assert False, "unhandled option"

    test_streams(CODEC_STR, INPUT_FILE)
    return

if __name__ == '__main__':
    main()