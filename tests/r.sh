export PATH="$PATH:$HOME/.local/bin"
# test all pythone script in this folder
# pytest -s
# pytest h264 stream only
# pytest -s test_h264.py
# pytest -s test_hevc.py
# pytest -s test_av1.py
# pytest -s test_vp9.py

# pytest -s test_via_vaapi-fits.py
pytest test_via_libva-utils.py
