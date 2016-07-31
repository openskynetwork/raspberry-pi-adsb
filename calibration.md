# (Optionally) calibrate your receiver

This step is optional, from my experience, NooElec receivers don't need calibration. 

Calibration stepsinstructions below are taken from the [following guide](http://www.satsignal.eu/raspberry-pi/acars-decoder.html#kalibrate).

```
mkdir ~/kal
cd ~/kal
sudo apt-get install libtool autoconf automake libfftw3-dev
git clone https://github.com/asdil12/kalibrate-rtl.git
cd kalibrate-rtl
git checkout arm_memory
./bootstrap
./configure
make
sudo make install
```

Make sure your antenna is connected to the RTL-SDR receiver and the receiver is connected to the Raspberri Pi. You should not use the band-pass filter yet.

To calibrate, run:

```
kal -s GSM900 -d 0 -g 40
```

You'll see something like:

```
Found 1 device(s):
  0:  Generic RTL2832U OEM

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Exact sample rate is: 270833.002142 Hz
[R82XX] PLL not locked!
Setting gain: 40.0 dB
kal: Scanning for GSM-900 base stations.
GSM-900:
	chan: 16 (938.2MHz - 303Hz)	power: 764382.95
	chan: 29 (940.8MHz - 107Hz)	power: 3099720.22
	chan: 37 (942.4MHz + 351Hz)	power: 814043.05
	chan: 56 (946.2MHz - 106Hz)	power: 255238.03
	chan: 65 (948.0MHz - 115Hz)	power: 645372.85
	chan: 69 (948.8MHz + 115Hz)	power: 4609305.74
	chan: 73 (949.6MHz + 239Hz)	power: 642985.06
	chan: 102 (955.4MHz - 512Hz)	power: 694681.27
```

Use the most powerful channel (69 in the example above) for calibration

kal -c <channel> -d 0 -g 40

You'll get something like:

```
Found 1 device(s):
  0:  Generic RTL2832U OEM

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Exact sample rate is: 270833.002142 Hz
[R82XX] PLL not locked!
Setting gain: 40.0 dB
kal: Calculating clock frequency offset.
Using GSM-900 channel 69 (948.8MHz)
average		[min, max]	(range, stddev)
+  64Hz		[39, 87]	(49, 13.600428)
overruns: 0
not found: 0
average absolute error: -0.067 ppm
```

Note the "average absolute error" number. If you have it around 0, everything's fine.
If not, you may need to change the frequency when you start `dump1090`.
