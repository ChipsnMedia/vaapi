
#Configuring permissions
stat -c "%G" /dev/dri/render*
groups ${USER}

# sudo gpasswd -a ${USER} render
# newgrp render

# export LIBVA_DRIVERS_PATH=/home/ta/project/vaapi/intel-vaapi-driver/src/.libs
export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
export LIBVA_DRIVER_NAME=i965
export LIBVA_TRACE=./result/va_trace.txt
vainfo
rm -rf result
mkdir result
# decoder

  
#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/DXVAContent/hevc/HEVC_3840x2160_64tiles_sao_cross_tile.hevc.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/hevc/HEVC_3840x2160_64tiles_sao_cross_tile.hevc ./result/output.yuv -y

#export LIBVA_VA_BITSTREAM=/Stream/work/gregory/DXVAContent/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i /Stream/work/gregory/DXVAContent/h264/Soccer_1280x720p_4mbps_30fps_Baseline_at_L3.1_8slices.MP4 ./result/output.yuv -y

#export LIBVA_VA_BITSTREAM=./result/Allegro_MMCO_CABAC_00_L30_SD576@25Hz_10.2.26l.mp4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/Allegro_MMCO_CABAC_00_L30_SD576@25Hz_10.2.26l.mp4 ./result/output.yuv -y

#export LIBVA_VA_BITSTREAM=./result/Allegro_MMCO_CAVLC_00_L30_SD576@25Hz_10.2.26l.mp4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/Allegro_MMCO_CAVLC_00_L30_SD576@25Hz_10.2.26l.mp4 ./result/output.yuv -y

export LIBVA_VA_BITSTREAM=./result/AIR_320x240_264.avi.ivf
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/AIR_320x240_264.avi ./result/output.yuv -y
#
#export LIBVA_VA_BITSTREAM=./result/Utraviolet.2006_x264_Clip00.avi.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/Utraviolet.2006_x264_Clip00.avi ./result/output.yuv -y
#
#export LIBVA_VA_BITSTREAM=./result/Utraviolet.2006_x264_Clip00_2Ref.avi.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/Utraviolet.2006_x264_Clip00_2Ref.avi ./result/output.yuv -y
#
#export LIBVA_VA_BITSTREAM=./result/hevc_AMP_A_Samsung_4.mp4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/AMP_A_Samsung_4.mp4 ./result/AMP_A_Samsung_4.yuv -y
#
#export LIBVA_VA_BITSTREAM=./result/hevc_AMP_B_Samsung_4.mp4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/AMP_B_Samsung_4.mp4 ./result/AMP_B_Samsung_4.yuv -y
#
#export LIBVA_VA_BITSTREAM=./result/Allegro_HEVC_Main_HT50_FUNNY_00_1920x1080@60Hz_2.9.bin.mp4.ivf
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i ./stream/Allegro_HEVC_Main_HT50_FUNNY_00_1920x1080@60Hz_2.9.bin.mp4 ./result/output.yuv -y

# encoder : Encode with H.264 at good constant quality: input.mp4를 software로 nv12 format으로 디코딩해서 hw encoder로 qp18로 인코딩한다.
#ffmpeg -vaapi_device /dev/dri/renderD128 -i ./stream/AIR_320x240_264.avi -vf 'format=nv12,hwupload' -c:v h264_vaapi -qp 18 ./result/output_qp18.mp4

# encoder : Hardware-only transcode to H.264 at 2Mbps CBR: input.mp4를 hardware로 decoding해서 enocder hardware로 바로 넘기고(YUV buffer 생성없이) hardware encoder로 2Mbps CBR로 인코딩한다.
#ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i ./stream/AIR_320x240_264.avi -c:v h264_vaapi -b:v 2M -maxrate 2M ./result/output_2Mbps.mp4

