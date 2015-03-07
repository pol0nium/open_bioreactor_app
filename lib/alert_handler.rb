def check_temperature_limits(curr_temp)
  unless ENV['min_temp'].nil?
    if curr_temp < ENV['min_temp'].to_f
      Mailer.instance.alert('TEMP', ENV['min_temp'], ENV['max_temp'], curr_temp)
    end
  end

  unless ENV['max_temp'].nil?
    if curr_temp > ENV['max_temp'].to_f
      Mailer.instance.alert('TEMP', ENV['min_temp'], ENV['max_temp'], curr_temp)
    end
  end
end

def check_ph_limits(curr_ph)
  unless ENV['min_ph'].nil?
    if curr_ph < ENV['min_ph'].to_f
      Mailer.instance.alert('PH', ENV['min_ph'], ENV['max_ph'], curr_ph)
    end
  end

  unless ENV['max_ph'].nil?
    if curr_ph > ENV['max_ph'].to_f
      Mailer.instance.alert('PH', ENV['min_ph'], ENV['max_ph'], curr_ph)
    end
  end
end

def check_oh_limits(curr_oh)
  unless ENV['min_oh'].nil?
    if curr_oh < ENV['min_oh'].to_f
      Mailer.instance.alert('OH', ENV['min_oh'], ENV['max_oh'], curr_oh)
    end
  end

  unless ENV['max_oh'].nil?
    if curr_oh > ENV['max_oh'].to_f
      Mailer.instance.alert('OH', ENV['min_oh'], ENV['max_oh'], curr_oh)
    end
  end
end