# Description:
#   Show zithub code of conduct
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot nuestro código - muestra nuestro código de conducta
#
# Author:
#   Francho

https = require 'https'

module.exports = (robot) ->
  robot.respond /nuestro c.digo/i, (msg) ->
    rulesUrl = 'https://raw.githubusercontent.com/francho/zithub-slackin/master/code-of-conduct.md'
    https.get rulesUrl, (res) ->
      data = ''
      res.on 'data', (chunk) ->
        data += chunk.toString()
      res.on 'end', () ->
        msg.reply data

