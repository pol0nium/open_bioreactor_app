require 'singleton'
require 'mail'

class Mailer
	include Singleton

	def initialize
		Mail.defaults do
  		delivery_method :smtp, :address    		=> 'smtp.gmail.com',
                      	:port       					=> 587,
                      	:user_name 						=> ENV['gmail_username'],
                      	:password   					=> ENV['gmail_password'],
                      	:authentication       => 'plain',
            			:enable_starttls_auto => true
		end
		@last_alerts = {}
	end

	def alert(type, min, max, current)
		now = Time.now
		if @last_alerts[type].nil? or (now - @last_alerts[type]) > ENV['alert_interval'].to_f
			@last_alerts[type] = now
			min ||= 'Not set'
			max ||= 'Not set'
			space = ' '
			variation = current < min.to_f ? 'LOW' : 'HIGH'
			subject = '[BIOREACTOR] ' + type + ' alert ! Value too ' + variation + '.'
body = <<BODY_END
Dear scientist,

########################################
#                               ALERT !                               #
########################################

The #{type} value is too #{variation} !

Current value : #{current}
Min value : #{min}
Max value : #{max}

Regards,

--#{space}
Your beloved Bioreactor
BODY_END
			SCHEDULER.in '0s' do
				Mail.deliver do
	      	to 			ENV['alert_mail_to']
	      	from 		ENV['alert_mail_to']
	  			subject subject
	      	body 		body
				end
			end
		end
	end
end

