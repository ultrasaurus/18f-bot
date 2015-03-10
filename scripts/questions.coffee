# Description:
#   Love is the script which captures lines like "I love donuts"
#   and places the content in the channel of your choosing, eg. #love
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None

module.exports = (robot) ->

  canonical = (text) ->
    text.trim().toLowerCase().replace(/[,.?!;()'"]/g, '')

  robot.brain.on 'loaded', ->
    robot.brain.questions = []
    robot.brain.question_index = {}

  robot.hear /^(.*\?.*)/i, (msg) ->
    asker = msg.message.user.name
    question = msg.match[0]
    questions_room = "#questions"
    message = msg.message
    message_id = message.id.split('.').join("")
    console.log(message)

    question_key = canonical(message.text)
    console.log("key: #{question_key}")
    found_id = robot.brain.question_index[question_key]
    if found_id == undefined
      console.log('not found')

      question = {
        text: message.text
        rawText: message.rawText
        canonicalText: question_key
        ts: message.ts
        user: message.user.id
        room: message.room
        channel: message.rawMessage.channel
        messageId: message.id
      }

      id = robot.brain.questions.length
      robot.brain.questions[id] = question
      robot.brain.question_index[question_key] = id
    else
      console.log('found id: ' + found_id + "question: " + robot.brain.questions[found_id].text)

    console.log(robot.brain.questions)

    room_link = "<##{message.rawMessage.channel}|#{message.room}>"
    message_link = "https://ultrasaurus.slack.com/archives/#{message.room}/p#{message_id}"

    robot.messageRoom questions_room, asker + " asked a question in " + room_link + ": " + message_link
    msg.send "We'll get back to you! Thanks, #{asker}!"
