# Description:
#   expose is alive?
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Author:
#   francho@spines.me


module.exports = (robot) ->
  robot.router.get '/hubot/is-alive', (req, res) ->
    res.send 'OK'
