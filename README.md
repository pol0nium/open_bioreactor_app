--------------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):

<bourg.matt@gmail.com> wrote this file. As long as you retain this notice
you can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return. -- Matthias Bourg
--------------------------------------------------------------------------------

# Installation

/!\ MAC OS only for now (not tested with another OS)

## Arduino setup

The arduino will query the sensors and send their data to a socket as a stream.

1) Install the arduino main software


How to :

- Go to http://arduino.cc/en/Main/Software

- Download package Arduino 1.0.6

=> You will need to have Java SE 6 installed in your computer (if not you will have a pop up with a direct link for download it when trying to install Arduino.app)

2) Install the sensors libraries

- Go to these links and download the latest versions of the libraries:
http://milesburton.com/Dallas_Temperature_Control_Library#Download
http://playground.arduino.cc/Learning/OneWire
- Plug the usb of the Arduino board to your computer
- Launch Arduino.app
- In the app: go to Tools->Type of board and select `Arduino Mega 2560 or Mega ADK`
- In the app: go to Tools->Serial port and select `/dev/tty.usbmodemXXX`

=> This is the serial port you will have to put in the configuration file

- In the app: go to File->Open and select `bioreactor.ino` (which should be on your computer, this file will be available for everyone in GitHub but not for now, it is our private file)
- Another window should open with our code inside
- In the app: go to Sketch->Import library and select `OneWire` and `dallas-temperature-control` (the 2 you have downloaded before)
- Click the “upload” button to transfer the software from the computer to the Arduino board

## Dashboard setup

- Extract “open_bioreactor-master.zip” or clone the git repository of the project in a folder
- In a terminal:
- Check ruby version (should be above 2.0): `ruby -version`
- Go to that folder and run `gem install bundler`
- Finally run `bundle install`
- Create the configuration file `config.yml` in the project folder containing the following :
```
---
arduino_path: '/dev/tty.usbmodemxxxx'
alert_mail_to: 'xxxxxx'
gmail_username: 'xxxxxxx'
gmail_password: 'xxxxxxxxxx'
alert_interval: 20 # Send mail alert every X seconds
```
- Change the Arduino path with the path you have in the Arduino app (the one you already have selected before ,should also be written in the bottom right of the app, should be like `/dev/tty.usbmodemXXXX`)  and save it
- Run `dashing start`
- In a web browser go to `localhost:3030`