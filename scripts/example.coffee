# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

# cronJob = require('cron').CronJob

module.exports = (robot) ->
  robot.hear /(むぎ|ムギ)/i,(msg) ->
    henji = msg.random [
      "なんだわん？"
      "ご飯？"
      "ちら(´・ω・｀)"
      "(`･ω･´)"
      "_(:3 ⌒ﾞ)_ｶｷｶｷ"
    ]
    msg.reply "#{henji}"
  robot.hear /かわいい/i,(msg) ->
    kawaii = msg.random [
      "なぁに？"
      "むぎのことですね？"
    ]
    msg.reply "#{kawaii}"
  robot.hear /(わん|ワン)/i,(msg) ->
    wan = msg.random [
      "だわん！"
      "だワン！"
      "わんわん(｀・ω・´)"
    ]
    msg.reply "#{wan}"
  robot.hear /(ご飯|ごはん|おやつ)/i,(msg) ->
    meshi = msg.random [
      "ちょーだい"
      "むぎにもちょーだい"
      "(´･ω･`)"
    ]
    msg.reply "#{meshi}"
  robot.hear /(たべる|食べる)？/i,(msg) ->
    msg.reply "たべる！"
  robot.hear /(あそぶ|遊ぶ)？/i,(msg) ->
    asobu = msg.random [
      "あしょぶー"
      "あしょばなーい"
    ]
    msg.send "#{asobu}"
  robot.hear /おでかけ/i,(msg) ->
    msg.reply "むぎもー！"
  robot.hear /じじ/i,(msg) ->
    jiji = msg.random [
      "じじー！"
      "あしょべー"
    ]
    msg.send "#{jiji}"
  robot.hear /ばば/i,(msg) ->
    baba = msg.random [
      "ばばー！"
      "あしょべー"
    ]
    msg.send "#{baba}"
  robot.hear /まま/i,(msg) ->
    mama = msg.random [
      "ままー！"
      "だっこ！"
      "なにかごよう(´・ω・｀)？"
    ]
    msg.send "#{mama}"
  robot.hear /(ゆみ|ゆんくん|むみ|ユミ|ユン)/i,(msg) ->
    mumi = msg.random [
      "ゆみねぇね！"
      "ねぇねー"
      "ちっちゃいねぇねー"
    ]
    msg.send "#{mumi}"
  robot.hear /(とんくん|トン君|とん君)/i,(msg) ->
    ton = msg.random [
      "(゜Д゜)ぺっ"
      "きらーい"
    ]
    msg.send "#{ton}"
  robot.hear /(こっくん|こけ|こうすけ|こーすけ)/i,(msg) ->
    koke = msg.random [
      "こーすけ、すきー"
      "こっくんーーーー"
      "こっくんあそんでー"
    ]
    msg.send "#{koke}"
  robot.hear /(くつした|靴下)/i,(msg) ->
    msg.send "これむぎのー！"
  robot.hear /おはよう/i,(msg) ->
    msg.send "まだねむいわん"
  robot.hear /おやすみ/i,(msg) ->
    msg.send "むぎもねるわん"
  robot.hear /(散歩|さんぽ|おて|お手|ぐるん|すわれ|たっちっち|座れ)/i,(msg) ->
    msg.send "やだわん！"
  robot.hear /(よんでない|ちがう|もう食べたでしょ)！/i,(msg) ->
    msg.send "(´･ω･`)？"

  robot.hear /天気 (.+)/i, (msg) ->
    para = msg.match[0].split(/\s+/)
    if para[1] == "東京"
      cid = 130010
    else if para[1] == "山口"
      cid = 350020
    else if para[1] == "宮崎"
      cid = 450010
    else if para[1] == "福岡"
      cid = 400010
    if para[2] == "今日"
      day = 0
    else if para[2] == "明日"
      day = 1
    else if para[2] == "明後日"
      day = 2
    searchWeather(cid, para[1], day, msg)


  searchWeather = (cid, place, day, msg) ->
    request = robot.http("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{cid}").get()
    stMessage = request (err, res, body) ->
      json = JSON.parse body
      weather = json['forecasts'][day]['telop']
      icon = json['forecasts'][day]['image']['url']
      if json['forecasts'][day]['temperature']['max'] != null
        temp_max = json['forecasts'][day]['temperature']['max']['celsius']
        tmaxb = true
      else
        tmaxb = false
      if json['forecasts'][day]['temperature']['min']
        temp_min = json['forecasts'][day]['temperature']['min']['celsius']
        tminb = true
      else
        tminb = false
      if day == 0
        d = "今日"
      else if day == 1
        d = "明日"
      else if day == 2
        d = "明後日"
      mes = d + "の#{place}の天気は「" + weather + "」だわん。\n"
      if tmaxb
        mes = mes + "最高気温："  + temp_max + "℃\n"
      if tminb
        mes = mes + " 最低気温：" + temp_min + "℃\n"
      mes = mes + icon
      msg.send mes



  searchWeatherCron = (cid, place) ->
    request = robot.http("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{cid}").get()
    stMessage = request (err, res, body) ->
      json = JSON.parse body
      weather = json['forecasts'][0]['telop']
      icon = json['forecasts'][0]['image']['url']
      if json['forecasts'][0]['temperature']['max'] != null
        temp_max = json['forecasts'][0]['temperature']['max']['celsius']
        tmaxb = true
      else
        tmaxb = false
      if json['forecasts'][0]['temperature']['min']
        temp_min = json['forecasts'][0]['temperature']['min']['celsius']
        tminb = true
      else
        tminb = false
      mes = "今日の#{place}の天気は「" + weather + "」だわん。\n"
      if tmaxb
        mes = mes + "最高気温："  + temp_max + "℃\n"
      if tminb
        mes = mes + " 最低気温：" + temp_min + "℃\n"
      mes = mes + icon
      robot.send {room: "#general"}, mes

  # robot.hear /badger/i, (res) ->
  #   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
