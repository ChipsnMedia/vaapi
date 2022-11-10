
# echo $HOME
export PATH="$PATH:$HOME/.local/bin"
# echo $PATH

if [ $# eq  1 ]; then

 	echo "+start prom downloading"
	cd /home/ta-ubuntu/Users/nas/wave517_br/fpga/board/ref-sw-5.0/vdi/linux/driver
	sudo sh unload.sh
	sudo sh load.sh
	cd /home/ta-ubuntu/Users/nas/wave517_br/fpga/board/ref-sw-5.0
	sh myprom.sh
 	echo "-start prom downloading"

 	echo "+start media-driver install"
	cd /home/ta-ubuntu/Users/gregory/vaapi_prj/vaapi/media-driver/build
	sudo make install
 	echo "-start media-driver install"

	cd /home/ta-ubuntu/Users/gregory/vaapi_prj/vaapi
fi



#Configuring permissions
stat -c "%G" /dev/dri/render*
groups ${USER}

# sudo gpasswd -a ${USER} render
# newgrp render

export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
# export LIBVA_DRIVERS_PATH=/home/ta-ubuntu/Users/jeff/vaapi/media-driver/build/media_driver
export LIBVA_DRIVER_NAME=iHD
# export LIBVA_DRIVER_NAME=i965  # for gstreamer-vaapi v1.14.5
export LIBVA_MESSAGING_LEVEL=2
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

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp2/[P]ATSC_18.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp2/[P]ATSC_18.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp2/[P]ATSC_18.avi /Stream/work/gregory/vastream/mp2/[P]ATSC_18.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp2/2Fast_2Furious_720P_mp2_800x600_2.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp2/2Fast_2Furious_720P_mp2_800x600_2.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp2/2Fast_2Furious_720P_mp2_800x600_2.avi /Stream/work/gregory/vastream/mp2/2Fast_2Furious_720P_mp2_800x600_2.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-001.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-001.ivf.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-001.ivf /Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-001.ivf.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-002.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-002.ivf.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-002.ivf /Stream/work/gregory/vastream/vp8/vp80-00-comprehensive-002.ivf.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/vc1/Tallship_320x240p_10mbps_29.97fps_AP_at_L0_6BFr_CBR_Noloopfilter.wmv.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/vc1/Tallship_320x240p_10mbps_29.97fps_AP_at_L0_6BFr_CBR_Noloopfilter.wmv.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/vc1/Tallship_320x240p_10mbps_29.97fps_AP_at_L0_6BFr_CBR_Noloopfilter.wmv /Stream/work/gregory/vastream/vc1/Tallship_320x240p_10mbps_29.97fps_AP_at_L0_6BFr_CBR_Noloopfilter.wmv.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/vc1/sample-wmv9-simple-SP@ML.wmv.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/vc1/sample-wmv9-simple-SP@ML.wmv.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/vc1/sample-wmv9-simple-SP@ML.wmv /Stream/work/gregory/vastream/vc1/sample-wmv9-simple-SP@ML.wmv.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp4/center_qvga_qp8.mp4.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp4/center_qvga_qp8.mp4.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp4/center_qvga_qp8.mp4.avi /Stream/work/gregory/vastream/mp4/center_qvga_qp8.mp4.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp4/metro_qvga_qp8.mp4.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp4/metro_qvga_qp8.mp4.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp4/metro_qvga_qp8.mp4.avi /Stream/work/gregory/vastream/mp4/metro_qvga_qp8.mp4.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp4/skull_qvga_qp8.mp4.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp4/skull_qvga_qp8.mp4.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp4/skull_qvga_qp8.mp4.avi /Stream/work/gregory/vastream/mp4/skull_qvga_qp8.mp4.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp4/albt_qvga_1500.mp4.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp4/albt_qvga_1500.mp4.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp4/albt_qvga_1500.mp4.avi /Stream/work/gregory/vastream/mp4/albt_qvga_1500.mp4.avi.yuv -y

# export LIBVA_TRACE=/Stream/work/gregory/vastream/mp4/april_qvga_qp8.mp4.avi.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/mp4/april_qvga_qp8.mp4.avi.ivf
# ffmpeg -loglevel verbose -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/mp4/april_qvga_qp8.mp4.avi /Stream/work/gregory/vastream/mp4/april_qvga_qp8.mp4.avi.yuv -y

# encoder : Encode with H.264 at good constant quality: input.mp4를 software로 nv12 format으로 디코딩해서 hw encoder로 qp18로 인코딩한다.
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/AIR_320x240_264.output.mp4.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/AIR_320x240_264.output.mp4.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/AIR_320x240_264.output.mp4.ivf.enc.yuv
# ffmpeg -vaapi_device /dev/dri/renderD128 -i /Stream/work/gregory/vastream/enc/AIR_320x240_264.input.avi -vf 'format=nv12,hwupload' -c:v h264_vaapi -qp 18 /Stream/work/gregory/vastream/enc/AIR_320x240_264.output.mp4 -y

#### AVC
# ## CBR
# ## test(bframes=2,bitrate=4000,case=720p,fps=30,gop=30,profile=main,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h264ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/A720p-cbr-main-30-30-4-2-4000k-4000k-0.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v main -rc_mode CBR -g 30 -slices 4 -bf 2 -b:v 4000k -maxrate 4000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h264

# ## CQP
# ## test(bframes=2,case=QVGA,gop=30,profile=main,qp=28,quality=4,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h264.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 320x240 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/QVGA_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v main -rc_mode CQP -g 30 -qp 28 -quality 4 -slices 4 -bf 2 -low_power 0 -vframes 300 -y /Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h264

# ##CQP_LP
# ## test(case=720p,gop=30,profile=high,qp=14,quality=4,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-cqp-high-30-14-4-4-1.h264.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-cqp-high-30-14-4-4-1.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-cqp-high-30-14-4-4-1.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v high -rc_mode CQP -g 30 -qp 14 -quality 4 -slices 4 -low_power 1 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-cqp-high-30-14-4-4-1.h264


# ## VBR
# # test(bframes=0,bitrate=4000,case=720p,fps=30,gop=30,profile=high,quality=4,refs=1,slices=3)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-4-0-4000k-8000k-0.h264.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-4-0-4000k-8000k-0.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-4-0-4000k-8000k-0.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v high -rc_mode VBR -g 30 -quality 4 -slices 3 -bf 0 -b:v 4000k -maxrate 8000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-4-0-4000k-8000k-0.h264

# # for fw developer
# # CQP
# # test(bframes=0,case=QVGA,gop=1,profile=main,qp=28,quality=4,slices=1) all IDR
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h264.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 320x240 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/QVGA_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v main -rc_mode CQP -g 1 -qp 28 -quality 4 -slices 1 -bf 0 -low_power 0 -vframes 300 -y /Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h264

# # VBR
# # test(bframes=0,bitrate=4000,case=720p,fps=30,gop=30,profile=high,quality=4,refs=1,slices=1)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-1_IPP.h264.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-1_IPP.h264.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-1_IPP.h264.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v h264_vaapi -profile:v high -rc_mode VBR -g 30 -quality 4 -slices 3 -bf 0 -b:v 4000k -maxrate 8000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-vbr-high-30-30-3-1_IPP.h264


# ###  HEVC
# ## CBR
# ## test(bframes=2,bitrate=4000,case=720p,fps=30,gop=30,profile=main,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/A720p-cbr-main-30-30-4-2-4000k-4000k-0.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode CBR -g 30 -slices 4 -bf 2 -b:v 4000k -maxrate 4000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-cbr-main-30-30-4-2-4000k-4000k-0.h265

# ## CQP
# ## test(bframes=2,case=QVGA,gop=30,profile=main,qp=28,quality=4,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 320x240 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/QVGA_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode CQP -g 30 -qp 28 -quality 4 -slices 4 -bf 2 -low_power 0 -vframes 300 -y /Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4-4-2-0.h265

# ##CQP_LP
# ## test(case=720p,gop=30,profile=main,qp=14,quality=4,slices=4)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-cqp-main-30-14-4-4-1.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-cqp-main-30-14-4-4-1.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-cqp-main-30-14-4-4-1.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode CQP -g 30 -qp 14 -quality 4 -slices 4 -low_power 1 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-cqp-main-30-14-4-4-1.h265


# ## VBR
# # test(bframes=0,bitrate=4000,case=720p,fps=30,gop=30,profile=main,quality=4,refs=1,slices=3)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-4-0-4000k-8000k-0.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-4-0-4000k-8000k-0.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-4-0-4000k-8000k-0.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode VBR -g 30 -quality 4 -slices 3 -bf 0 -b:v 4000k -maxrate 8000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-4-0-4000k-8000k-0.h265

# # for fw developer
# # CQP
# # test(bframes=0,case=QVGA,gop=1,profile=main,qp=28,quality=4,slices=1) all IDR
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 320x240 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/QVGA_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode CQP -g 1 -qp 28 -quality 4 -slices 1 -bf 0 -low_power 0 -vframes 300 -y /Stream/work/gregory/vastream/enc/QVGA-cqp-main-30-28-4_all_IDR.h265

# # VBR
# # test(bframes=0,bitrate=4000,case=720p,fps=30,gop=30,profile=main,quality=4,refs=1,slices=1)
# export LIBVA_TRACE=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-1_IPP.h265.ivf.va_trace.txt
# export LIBVA_VA_BITSTREAM=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-1_IPP.h265.ivf
# export LIBVA_TRACE_SURFACE=/Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-1_IPP.h265.ivf.enc.yuv
# ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -v verbose -f rawvideo -pix_fmt nv12 -s:v 1280x720 -r:v 30 -i /home/ta/vaapi_prj/vaapi/vaapi-fits/assets/yuv/720p_NV12.yuv -vf 'format=nv12,hwupload' -c:v hevc_vaapi -profile:v main -rc_mode VBR -g 30 -slices 3 -bf 0 -b:v 4000k -maxrate 8000k -low_power 0 -vframes 150 -y /Stream/work/gregory/vastream/enc/720p-vbr-main-30-30-3-1_IPP.h265



# encoder : Hardware-only transcode to H.264 at 2Mbps CBR: input.mp4를 hardware로 decoding해서 enocder hardware로 바로 넘기고(YUV buffer 생성없이) hardware encoder로 2Mbps CBR로 인코딩한다.
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i /Stream/work/vastream/AIR_320x240_264.avi -c:v h264_vaapi -b:v 2M -maxrate 2M ./result/output_2Mbps.mp4

# gtest of libva-utils
#test_va_api > test_va_api_result.txt


# for libva-fits
# Run only gst-vaapi test cases on iHD driver for KBL platform

# export GST_VAAPI_ALL_DRIVERS=1 
export VAAPI_FITS_CONFIG_FILE=./config/conformance
export ITU_T_ASSETS=/Stream/work/ITU_T_ASSETS
cd vaapi-fits
# #  ./vaapi-fits list | grep test/ffmpeg-vaapi
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/mpeg4.py --platform TGL --call-timeout 6000000 -v
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/avc.py --platform TGL --call-timeout 6000000 -v
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/mpeg2.py --platform TGL --call-timeout 6000000 -v
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/h263.py --platform TGL --call-timeout 6000000 -v
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/vp8.py --platform TGL --call-timeout 6000000 -v
#./vaapi-fits -v run test/ffmpeg-vaapi/decode/vc1.py --platform TGL --call-timeout 6000000 -v
#   ./vaapi-fits -v run test/ffmpeg-vaapi/decode/av1.py --platform TGL --call-timeout 6000000 -v
# #  ./vaapi-fits -v run test/ffmpeg-vaapi/decode/10bit/vp9.py --platform TGL --call-timeout 6000000 -v
#   ./vaapi-fits -v run test/ffmpeg-vaapi/decode/10bit/av1.py --platform TGL --call-timeout 6000000 -v
#  ./vaapi-fits -v run test/ffmpeg-vaapi/decode --platform TGL --call-timeout 6000000 -v
#  ./vaapi-fits run test/ffmpeg-vaapi/encode/avc.py --platform TGL --call-timeout 6000000 -v
 ./vaapi-fits run test/ffmpeg-vaapi/encode/avc.py --platform TGL --call-timeout 6000000 -v --cnm_refc_dir /Stream/work/gregory/vaapi_enc_test_1008
#  ./vaapi-fits run test/ffmpeg-vaapi/encode/hevc.py --platform KBL --call-timeout 6000000 -v
#  ./vaapi-fits run test/ffmpeg-vaapi/encode/10bit/hevc.py --platform KBL --call-timeout 6000000 -v
# #  ./vaapi-fits run test/ffmpeg-vaapi/transcode --platform TGL --call-timeout 6000000
 cd ..

# ninja -C gst-build/builddir devenv # create new shell that enter an development environment where you will be able to work on GStreamer easily.
# # if new shell is created. run the below commands

# # export GST_DEBUG=4 # 2:WARNING, 4:INFO, 5:DEBUG, 6:LOG, 7:TRACE
# export GST_VAAPI_ALL_DRIVERS=1 
# export VAAPI_FITS_CONFIG_FILE=./config/vpu
# gst-inspect-1.0 vaapi
# #  ./vaapi-fits list | grep test/gst-vaapi
#  ./vaapi-fits -v run test/gst-vaapi/decode --platform KBL --call-timeout 6000000
# #  ./vaapi-fits run test/gst-vaapi/encode --platform KBL --call-timeout 6000000
# #  ./vaapi-fits run test/gst-vaapi/transcode --platform KBL --call-timeout 6000000 
