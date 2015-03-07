class Dashing.Timer extends Dashing.Widget

  ready: ->
    if ($.jStorage.get('start_timer'))
      @start = new Date($.jStorage.get('start_timer'))
    else
      @start = new Date()
    h = @start.getHours()
    m = @start.getMinutes()
    s = @start.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    @set('init', "Experiment started at: " + @start.toDateString() + " " + h + ":" + m + ":" + s)
    $.jStorage.set('start_timer', @start)
    setInterval(@startTime, 500)
    $('#reset-timer').bind 'click', (event) =>
      $.jStorage.deleteKey('start_timer')
      @ready()

  startTime: =>
    now = new Date()
    timeDiff = now - @start
    timeDiff /= 1000
    seconds = Math.round(timeDiff % 60)
    timeDiff = Math.floor(timeDiff / 60)
    minutes = Math.round(timeDiff % 60)
    timeDiff = Math.floor(timeDiff / 60)
    hours = Math.round(timeDiff % 24)
    timeDiff = Math.floor(timeDiff / 24)
    days = timeDiff

    @set('time', days + " d " + hours + " h " + minutes + " m " + seconds + " s")

    new_today = new Date()

    new_h = new_today.getHours()
    new_m = new_today.getMinutes()
    new_s = new_today.getSeconds()
    new_m = @formatTime(new_m)
    new_s = @formatTime(new_s)
    @set('today_time', new_h + ":" + new_m + ":" + new_s)
    @set('date', new_today.toDateString())

  formatTime: (i) ->
    if i < 10 then "0" + i else i