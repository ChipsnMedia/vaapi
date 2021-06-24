
import pytest
from common import*


STREAM_ROOT_av1 = "/Stream/work/gregory/DXVAContent/av1"
REFC_FILE_PATH_av1 ="../../TRY_WAVE517-E_REL_v1.9.9_VAAPI/design/ref_c/bin/Linux/av1_dec"
CODEC_STR_av1 = "av1_dec"

@pytest.mark.parametrize("stream_name", get_test_stream_list(STREAM_ROOT_av1))
def test_av1_streams(stream_name):
    ret = False
    print("+" + get_f_name() + " stream_name=" + stream_name)
    file_name_list = get_file_name_list(stream_name)
    ret = decode_vaapi_ffmpeg(file_name_list, False, True)
    assert ret == True
    ret = decode_cnm_ref_c(REFC_FILE_PATH_av1, CODEC_STR_av1, file_name_list, False)
    assert ret == True
    ret = decode_cnm_ref_c(REFC_FILE_PATH_av1, CODEC_STR_av1, file_name_list, True)
    assert ret == True
    ret = compare_output(file_name_list, TC_COMPARE_REFC_AND_VAAPI_REFC)
    print("-" + get_f_name() + " TC_COMPARE_REFC_AND_VAAPI_REFC ret=" + str(ret))
    assert ret == True

    # ret = decode_vaapi_app(file_name_list)
    # assert ret == True
    # ret = compare_output(file_name_list, TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC)
    # print("-" + get_f_name() + " TC_COMPARE_VAAPI_APP_AND_VAAPI_REFC ret=" + str(ret))
    # assert ret == True

    # ret = decode_vaapi_ffmpeg(file_name_list, True, False)
    # assert ret == True
    # ret = compare_output(file_name_list, TC_COMPARE_VAAPI_FFMPEG_AND_CNM_VAAPI_FFMPEG)
    # print("-" + get_f_name() + " TC_COMPARE_VAAPI_FFMPEG_AND_CNM_VAAPI_FFMPEG ret=" + str(ret))
    # assert ret == True


# def main():
#     test_stream_list = get_test_stream_list(STREAM_ROOT_av1)

#     # test_stream_list just has stream names.
#     for stream_name in test_stream_list: 
#         test_av1_streams(stream_name)
#     return

# if __name__ == '__main__':
#     main()