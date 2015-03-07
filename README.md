```
--------------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):

<bourg.matt@gmail.com> wrote this file. As long as you retain this notice
you can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return. -- Matthias Bourg
--------------------------------------------------------------------------------
```

# Installation

/!\ MAC OS only for now (not tested with another OS)

## Arduino setup

The arduino will query the sensors and send their data to a socket as a stream.

1) Install the arduino main software

Visit : https://github.com/pol0nium/open_bioreactor_arduino

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