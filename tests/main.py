import getopt
from common import*

REFC_FILE_ROOT="../../wave627_enc_wave517_dec_pvric_boda977_dec_single_vaapi_mthread_v3.3.3_vaapi_fpga"
VAAPI_APP_FILE_ROOT="../../wave627_enc_wave517_dec_pvric_boda977_dec_single_vaapi_mthread_v3.3.3_vaapi_fpga"

def test_streams(codec_str, input_file_name, test_case, bit_depth, output_file_name):
    print("+" + get_f_name() + " input_file_name=" + input_file_name + ",  codec_str=" + codec_str + " test_case=" + str(test_case) + " output_file_name=" + output_file_name);
    ret = False
    cmdstr_1 = ""
    cmdstr_2 = ""
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
    elif "avs2_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/avs2_dec"
    elif "vp8_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/vp8_dec"
    elif "vc1_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/vc1_dec"
    elif "mpeg2_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/mpeg2_dec"
    elif "mpeg4_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/mpeg4_dec"
    elif "h263_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/h263_dec"
    elif "avs_dec" in codec_str:
        refc_file_path = REFC_FILE_ROOT + "/avs_dec"
    else:
        print("+" + get_f_name() + " unknown codec_str = " + codec_str)
        return False

    vaapi_app_path = VAAPI_APP_FILE_ROOT + "/tc_dec_vaapi"
    set_bit_depth(bit_depth)
    file_name_list = get_file_name_list(stream_name)
    if output_file_name != "":
        file_name_list[FNI_VA_STREAM_NAME_IDX] = output_file_name
        file_name_list[FNI_TRACE_FILE_FROM_LIBVA] = os.path.dirname(output_file_name) + "/" + os.path.basename(output_file_name) + ".trace.txt"
        file_name_list[FNI_OUTPUT_FILE_VAAPI_FFMPEG] = os.path.dirname(output_file_name) + "/" + os.path.basename(output_file_name) + ".vaapi.ffmpeg.yuv"
        ret = decode_vaapi_ffmpeg(file_name_list, True)
        if ret == False:
            print("+" + get_f_name() + " fail to generate ivf file")
            return False
        return ret
    if test_case == TC_COMPARE_REFC_AND_VAAPI_REFC:
        ret = decode_vaapi_ffmpeg(file_name_list, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False

        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, False, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False
        cmdstr_1 = get_last_cmdstr()

        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, True, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c with vaapi mode")
            return False
        cmdstr_2 = get_last_cmdstr()

        ret = compare_output(file_name_list, TC_COMPARE_REFC_AND_VAAPI_REFC)
        print("-" + get_f_name() + " TC_COMPARE_REFC_AND_VAAPI_REFC ret=" + str(ret))
        if ret == False:
            print("-" + get_f_name() + "cmdstr_1 : "+ cmdstr_1)
            print("-" + get_f_name() + "cmdstr_2 : "+ cmdstr_2)
    elif test_case == TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC:
        ret = decode_vaapi_ffmpeg(file_name_list, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False

        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, True, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c with vaapi mode")
            return False
        cmdstr_1 = get_last_cmdstr()

        ret = decode_cnm_vaapi_app(vaapi_app_path, codec_str, file_name_list)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False
        cmdstr_2 = get_last_cmdstr()

        ret = compare_output(file_name_list, TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC)
        print("-" + get_f_name() + " TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC ret=" + str(ret))
        if ret == False:
            print("-" + get_f_name() + "cmdstr_1 : "+ cmdstr_1)
            print("-" + get_f_name() + "cmdstr_2 : "+ cmdstr_2)
    elif test_case == TC_COMPARE_SW_FFMPEG_AND_REF:
        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, False, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False
        cmdstr_1 = get_last_cmdstr()

        ret = decode_swcodec_ffmpeg(file_name_list)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False
        cmdstr_2 = get_last_cmdstr()

        ret = compare_output(file_name_list, TC_COMPARE_SW_FFMPEG_AND_REF)
        print("-" + get_f_name() + " TC_COMPARE_SW_FFMPEG_AND_REF ret=" + str(ret))
        if ret == False:
            print("-" + get_f_name() + "cmdstr_1 : "+ cmdstr_1)
            print("-" + get_f_name() + "cmdstr_2 : "+ cmdstr_2)

    else:
        ret = decode_cnm_ref_c(refc_file_path, codec_str, file_name_list, False, True)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_cnm_ref_c without vaapi mode")
            return False
        cmdstr_1 = get_last_cmdstr()

        ret = decode_vaapi_ffmpeg(file_name_list, False)
        if ret == False:
            print("+" + get_f_name() + " fail to decode_vaapi_ffmpeg")
            return False
        cmdstr_2 = get_last_cmdstr()

        ret = compare_output(file_name_list, TC_COMPARE_VAAPI_FFMPEG_AND_REFC)
        print("-" + get_f_name() + " TC_COMPARE_VAAPI_FFMPEG_AND_REFC ret=" + str(ret))
        if ret == False:
            print("-" + get_f_name() + "cmdstr_1 : "+ cmdstr_1)
            print("-" + get_f_name() + "cmdstr_2 : "+ cmdstr_2)

    return ret

def usage():
    print("usage requred")
    return
def main():

    INPUT_FILE = "/Stream/work/gregory/DXVAContent/cnm/AIR_320x240_264.avi"
    OUTPUT_FILE = ""
    CODEC_STR = "avc_dec"
    BIT_DEPTH = 8
    TEST_CASE = 0  
    try:
        opts, args = getopt.getopt(sys.argv[1:],"hc:i:t:b:o:",["help", "codec=", "input=", "test_case=", "bit=", "output="])
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
        elif o in ("-o", "--output"):
            OUTPUT_FILE = a
        elif o in ("-t", "--test_case"):
            if a == "0":
                TEST_CASE = TC_COMPARE_VAAPI_FFMPEG_AND_REFC
            elif a == "1":
                TEST_CASE = TC_COMPARE_REFC_AND_VAAPI_REFC
            elif a == "2":
                TEST_CASE = TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC
            elif a == "3":
                TEST_CASE = TC_COMPARE_SW_FFMPEG_AND_REF
            else:
                assert False, "unhandled option"
        elif o in ("-b", "--bit"):
            if a == "10":
                BIT_DEPTH = 10 
            else:
                BIT_DEPTH = 8 
        else:
            assert False, "unhandled option"

    test_streams(CODEC_STR, INPUT_FILE, TEST_CASE, BIT_DEPTH, OUTPUT_FILE)
    return

if __name__ == '__main__':
    main()