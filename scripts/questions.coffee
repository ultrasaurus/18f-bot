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

  robot.hear /^(.*\?.*)/i, (msg) ->
    asker = msg.message.user.name
    question = msg.match[0]
    questions_room = "#questions"
    message = msg.message
    message_id = message.id.split('.').join("")
    console.log("message_id: #{message_id}")

    room_link = "<##{message.rawMessage.channel}|#{message.room}>"
    message_link = "https://ultrasaurus.slack.com/archives/#{message.room}/p#{message_id}"

    robot.messageRoom questions_room, asker + " asked a question in " + room_link + ": " + message_link
    msg.send "We'll get back to you! Thanks, #{asker}!"
