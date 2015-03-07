require 'serialport'
require 'yaml'
require File.join(Dir.pwd + '/lib/', 'alert_handler')

# Data initialisation
config = YAML::load_file(File.join(Dir.pwd, 'config.yml'))
ENV['arduino_path'] = config['arduino_path']
ENV['alert_mail_to'] = config['alert_mail_to']
ENV['gmail_username'] = config['gmail_username']
ENV['gmail_password'] = config['gmail_password']
ENV['alert_interval'] = config['alert_interval'].to_s
baud_rate = 38400
wait_time = 10
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
port_file = ENV['arduino_path']
#create a SerialPort object using each of the bits of information
port = SerialPort.new(port_file, baud_rate, data_bits, stop_bits, parity)
temperature = 0.0
ph = 0.0
oh = 0.0
temperature_points = []
ph_points = []
oh_points = []

SCHEDULER.every '2s' do
	File.write(settings.history_file, settings.history.to_yaml)
	5.times do
		data = port.readline.split(":")
	  next if data.length != 2
	  case data[0].strip
	  when "T"
	  	temperature = data[1].strip.to_f
	  when "OH"
	  	oh = data[1].strip.to_f
	  when "PH"
	  	ph = data[1].strip.to_f
	 	end
	end
	x = Time.now.to_i * 1000
	port.flush_input
	temperature_points << { x: x, y: temperature}
	ph_points << { x: x, y: ph}
	oh_points << { x: x, y: oh}

	if ENV['reset'].eql? 'true'
		temperature_points = []
		ph_points = []
		oh_points = []
		ENV['reset'] = 'false'
	end

	# Widget updates
  send_event('temperature', { value: temperature })
  send_event('ph', { value: ph })
  send_event('oh', { value: oh })	
  send_event('temperature-highchart', { series: [{ data: temperature_points }], color: '#D3613B', title: 'Temperature', ytitle: 'Degrees Celsius'})
	send_event('ph-highchart', { series: [{ data: ph_points }], color: '#9DE168', title: 'PH', ytitle: ''})
	send_event('oh-highchart', { series: [{ data: oh_points }], color: '#49ABEA', title: 'OH', ytitle: ''})

  @temperature = temperature
  # Limits checks
  check_temperature_limits(temperature) unless temperature.nil?
  check_ph_limits(ph) unless ph.nil?
  check_oh_limits(oh) unless oh.nil?
end