

#Configuring permissions
stat -c "%G" /dev/dri/render*
groups ${USER}

# sudo gpasswd -a ${USER} render
# newgrp render

export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
# export LIBVA_DRIVERS_PATH=/home/ta-ubuntu/Users/gregory/vaapi/media-driver/build/media_driver

export LIBVA_DRIVER_NAME=iHD
# export LIBVA_DRIVER_NAME=i965  # for gstreamer-vaapi v1.14.5
export LIBVA_MESSAGING_LEVEL=2
export LIBVA_TRACE=./result/va_trace.txt
vainfo

rm -rf result
mkdir result


# decoder



# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/DXVAContent/h264/ivf/H264formatChange_1920x1088_High_at_L4.1_1280x720_Main.264.ivf
# /usr/local/bin/ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/H264formatChange_1920x1088_High_at_L4.1_1280x720_Main.264 -f rawvideo -pix_fmt yuv420p /Stream/work/gregory/DXVAContent/h264/yuv/H264formatChange_1920x1088_High_at_L4.1_1280x720_Main.264.vaapi.ffmpeg.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/DXVAContent/h264/ivf/Rotate_180.mov.ivf

# /usr/local/bin/ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/Rotate_180.mov -f rawvideo -pix_fmt yuv420p /Stream/work/gregory/DXVAContent/h264/yuv/Rotate_180.mov.vaapi.ffmpeg.yuv -y 

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4 /Stream/work/gregory/vastream/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/Soccer_1280x720p_3mbps_25fps_High_at_L4.1_Cabac_frext_slice.mp4.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/Soccer_1280x720p_3mbps_25fps_High_at_L4.1_Cabac_frext_slice.mp4 /Stream/work/gregory/vastream/h264/Soccer_1280x720p_3mbps_25fps_High_at_L4.1_Cabac_frext_slice.mp4.yuv -y

#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4 /Stream/work/gregory/vastream/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/AIR_320x240_264.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/cnm/AIR_320x240_264.avi -f rawvideo -pix_fmt yuv420p /Stream/work/gregory/vastream/h264/AIR_320x240_264.avi.yuv -y
# gst-launch-1.0 -vf filesrc location=/Stream/work/gregory/DXVAContent/cnm/AIR_320x240_264.avi  ! h264parse ! vaapih264dec ! videoconvert ! video/x-raw,format=I420 ! filesink location=/Stream/work/gregory/vastream/h264/AIR_320x240_264.avi.gstreamer.yuv
# cmp /Stream/work/gregory/vastream/h264/AIR_320x240_264.avi.yuv /Stream/work/gregory/vastream/h264/AIR_320x240_264.avi.gstreamer.yuv


# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/Utraviolet.2006_x264_Clip00.avi.ivf.bak
# ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/cnm/Utraviolet.2006_x264_Clip00.avi -vf "select=eq(n\,3)" /Stream/work/gregory/vastream/h264/Utraviolet.2006_x264_Clip00.avi.yuv -y

#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/h264/Utraviolet.2006_x264_Clip00_2Ref.avi.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/cnm/Utraviolet.2006_x264_Clip00_2Ref.avi /Stream/work/gregory/vastream/h264/Utraviolet.2006_x264_Clip00_2Ref.avi.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/hevc/MSHDRef_Texture_SkinTones_08_320x240p24f_lowlevel_main_fuzzed.hevc.ivf
# ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/hevc/MSHDRef_Texture_SkinTones_08_320x240p24f_lowlevel_main_fuzzed.hevc /Stream/work/gregory/vastream/hevc/MSHDRef_Texture_SkinTones_08_320x240p24f_lowlevel_main_fuzzed.hevc.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/hevc/hevc_AMP_A_Samsung_4.mp4.ivf
# ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/cnm/AMP_A_Samsung_4.mp4 /Stream/work/gregory/vastream/hevc/hevc_AMP_A_Samsung_4.mp4.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/hevc/hevc_AMP_B_Samsung_4.mp4.ivf
# ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/cnm/AMP_B_Samsung_4.mp4 /Stream/work/gregory/vastream/hevc/hevc_AMP_B_Samsung_4.mp4.yuv -y

#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/vp9/hdr_skate_720p_1200.mkv.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/vp9/hdr_skate_720p_1200.mkv /Stream/work/gregory/vastream/vp9/hdr_skate_720p_1200.mkv.yuv -y

#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/av1/Balloons_426x240.mp4.ivf
##ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/av1/youtube_mp4/Balloons_426x240.mp4 /Stream/work/gregory/vastream/av1/Balloons_426x240.mp4.yuv -y
#ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/av1/youtube_mp4/Balloons_426x240.mp4 /Stream/work/gregory/vastream/av1/Balloons_426x240.mp4.yuv -y


# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/av1/Main_8bits_450_HighRes_720x576_r6009.ivf.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/av1/Main_8bits_450_HighRes_720x576_r6009.ivf /Stream/work/gregory/vastream/av1/Main_8bits_450_HighRes_720x576_r6009.ivf.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/av1/Main_8bits_000_Intra_192x128_r6009.ivf.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/av1/Main_8bits_000_Intra_192x128_r6009.ivf /Stream/work/gregory/vastream/av1/Main_8bits_000_Intra_192x128_r6009.ivf.yuv -y

# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/av1/Main_8bits_047_Inter_192x128_r6009.ivf.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/av1/Main_8bits_047_Inter_192x128_r6009.ivf /Stream/work/gregory/vastream/av1/Main_8bits_047_Inter_192x128_r6009.ivf.yuv -y

# encoder : Encode with H.264 at good constant quality: input.mp4를 software로 nv12 format으로 디코딩해서 hw encoder로 qp18로 인코딩한다.
#ffmpeg -vaapi_device /dev/dri/renderD128 -i /Stream/work/vastream/AIR_320x240_264.avi -vf 'format=nv12,hwupload' -c:v h264_vaapi -qp 18 ./result/output_qp18.mp4

# encoder : Hardware-only transcode to H.264 at 2Mbps CBR: input.mp4를 hardware로 decoding해서 enocder hardware로 바로 넘기고(YUV buffer 생성없이) hardware encoder로 2Mbps CBR로 인코딩한다.
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i /Stream/work/vastream/AIR_320x240_264.avi -c:v h264_vaapi -b:v 2M -maxrate 2M ./result/output_2Mbps.mp4

# gstreamer
# cd ./gst-build/builddir
# ninja devenv # set some env variables to use this build in default
# cd ..
export GST_DEBUG=2 # 2:WARNING, 4:INFO, 5:DEBUG, 6:LOG, 7:TRACE
export GST_VAAPI_ALL_DRIVERS=1 
gst-inspect-1.0 vaapi

# gtest of libva-utils
# test_va_api | grep FAIL

# for libva-fits
# Run only gst-vaapi test cases on iHD driver for KBL platform
# export GST_VAAPI_ALL_DRIVERS=1 
# ./vaapi-fits list
# ./vaapi-fits run test/gst-vaapi --platform KBL
# ./vaapi-fits run test/ffmpeg-vaapi --platform KBL
