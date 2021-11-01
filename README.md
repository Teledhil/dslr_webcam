# DSLR WEBCAM

sudo cp dslr-webcam.sh /usr/local/bin/dslr-webcam.sh

sudo cp dslr-webcam@.service /usr/lib/systemd/system/dslr-webcam@.service

sudo cp 99-dslr-webcam.rules /usr/lib/udev/rules.d/99-dslr-webcam.rules
sudo udevadm control --reload-rules
