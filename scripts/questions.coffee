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
    console.log(msg)
    question = msg.match[0]
    room = "#questions"
    robot.messageRoom room, asker + " asks: " + question
    msg.send "We'll get back to you! Thanks, #{asker}!"
