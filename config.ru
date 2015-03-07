require 'dashing'
require 'json'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'index'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

post '/alert/temperature' do
	ENV['min_temp'] = params[:min] if Float(params[:min]) rescue nil
	ENV['max_temp'] = params[:max] if Float(params[:max]) rescue nil

	redirect '/'
end

post '/alert/ph' do
	ENV['min_ph'] = params[:min] if Float(params[:min]) rescue nil
	ENV['max_ph'] = params[:max] if Float(params[:max]) rescue nil

	redirect '/'
end

post '/alert/oh' do
	ENV['min_oh'] = params[:min] if Float(params[:min]) rescue nil
	ENV['max_oh'] = params[:max] if Float(params[:max]) rescue nil

	redirect '/'
end

get '/details/all' do
	history = YAML.load_file('history.yml')

	temp_history = JSON.parse(history['temperature-highchart'][6..-1])
	temperature = temp_history["series"][0]["data"].map{|k,v| [k["x"],k["y"]]}

	ph_history = JSON.parse(history['ph-highchart'][6..-1])
	ph = ph_history["series"][0]["data"].map{|k,v| [k["x"],k["y"]]}

	oh_history = JSON.parse(history['ph-highchart'][6..-1])
	oh = oh_history["series"][0]["data"].map{|k,v| [k["x"],k["y"]]}

	erb :details, :locals => {:temperature => temperature, :ph => ph, :oh => oh}
end

get '/reset/all' do
	ENV['reset'] = 'true'
	Sinatra::Application.settings.history.clear
	redirect '/'
end

map Sinatra::Application.assets_prefix do
	Sinatra::Application.settings.history.clear
  run Sinatra::Application.sprockets
end

run Sinatra::Application