#!/bin/bash
cd ./tests
# ffmpeg -hwaccel vaapi -init_hw_device vaapi=hw:/dev/dri/renderD128 -hwaccel_flags allow_profile_mismatch -filter_hw_device hw -v verbose -i /Stream/work/ITU_T_ASSETS/avc/AVCv1/BASQP1_Sony_C.jsv -pix_fmt yuv420p -f rawvideo -vsync passthrough -autoscale 0 -vframes 4 -y /home/ta-ubuntu/Users/gregory/vaapi_prj/vaapi/vaapi-fits/results/aef78f0e-f8ee-11eb-9d75-41dd53cfeb79_0/_0.test.ffmpeg-vaapi.decode.avc/default/BASQP1_Sony_C_176x144_I420.yuv 
python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/BASQP1_Sony_C.jsv --test_case=1
# ffmpeg -hwaccel vaapi -init_hw_device vaapi=hw:/dev/dri/renderD128 -hwaccel_flags allow_profile_mismatch -filter_hw_device hw -v verbose -i /Stream/work/ITU_T_ASSETS/avc/AVCv1/CABA3_SVA_B.264 -pix_fmt yuv420p -f rawvideo -vsync passthrough -autoscale 0 -vframes 33 -y /home/ta-ubuntu/Users/gregory/vaapi_prj/vaapi/vaapi-fits/results/aef78f0e-f8ee-11eb-9d75-41dd53cfeb79_0/_0.test.ffmpeg-vaapi.decode.avc/default/CABA3_SVA_B_176x144_I420.yuv (pid: 56724)
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CABA3_SVA_B.264 --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CABA3_Sony_C.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CABACI3_Sony_B.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CABAST3_Sony_E.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CABREF3_Sand_D.264 --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CACQP3_Sony_D.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAFI1_SVA_C.264 --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAMA1_Sony_C.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAMA1_TOSHIBA_B.264 --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAMA3_Sand_E.264 --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAMACI3_Sony_C.jsv --test_case=1
# python3 ./main.py --codec=avc_dec --input=/Stream/work/ITU_T_ASSETS/avc/AVCv1/CAMANL1_TOSHIBA_B.264 --test_case=1
cd ..
