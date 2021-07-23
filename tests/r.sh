export PATH="$PATH:$HOME/.local/bin"
# export REFC_TEST_MODE="True" # for verifiying c&m c-model. it is used for c&m internel.
# test all pythone script in this folder
pytest -s
# pytest -s test_h264.py # pytest h264 stream only
# pytest -s test_hevc.py
# pytest -s test_av1.py
# pytest -s test_vp9.py
# pytest -s test_via_vaapi-fits.py
# pytest test_via_libva-utils.py
