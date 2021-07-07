
import pytest
from common import*

STREAM_ROOT_hevc = "/Stream/work/VAAPIContent/hevc"
REFC_FILE_PATH_hevc = "../../wave517_dec_pvric_nommf_mthread_v5.5.72_vaapi/hevc_dec"
CODEC_STR_hevc = "hevc_dec"

@pytest.mark.parametrize("stream_name", get_test_stream_list(STREAM_ROOT_hevc))
def test_hevc_streams(stream_name):
    ret = False
    print("+" + get_f_name() + " stream_name=" + stream_name)
    file_name_list = get_file_name_list(stream_name)

    if CNM_REFC_TEST == True:
        ret = decode_vaapi_ffmpeg(file_name_list, True)
        assert ret == True

        ret = decode_cnm_ref_c(REFC_FILE_PATH_hevc, CODEC_STR_hevc, file_name_list, False)
        assert ret == True

        ret = decode_cnm_ref_c(REFC_FILE_PATH_hevc, CODEC_STR_hevc, file_name_list, True)
        assert ret == True

        ret = compare_output(file_name_list, TC_COMPARE_REFC_AND_VAAPI_REFC)
        print("-" + get_f_name() + " TC_COMPARE_REFC_AND_VAAPI_REFC ret=" + str(ret))
    else:
        ret = decode_cnm_ref_c(REFC_FILE_PATH_hevc, CODEC_STR_hevc, file_name_list, False)
        assert ret == True

        ret = decode_vaapi_ffmpeg(file_name_list, False)
        assert ret == True

        ret = compare_output(file_name_list, TC_COMPARE_VAAPI_FFMPEG_AND_REFC)
        print("-" + get_f_name() + " TC_COMPARE_VAAPI_FFMPEG_AND_REFC ret=" + str(ret))

    assert ret == True

# def main():
#     test_stream_list = get_test_stream_list(STREAM_ROOT_hevc)

#     # test_stream_list just has stream names.
#     for stream_name in test_stream_list: 
#         test_hevc_streams(stream_name)
#     return

# if __name__ == '__main__':
#     main()


