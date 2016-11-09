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
#   las reglas/código de conducta/el código/
#
# Author:
#   Francho

https = require 'https'

module.exports = (robot) ->
  robot.respond /(las reglas|c.digo de conducta|el c.digo)/i, (msg) ->
    rulesUrl = 'https://raw.githubusercontent.com/francho/zithub-slackin/master/code-of-conduct.md'
    https.get rulesUrl, (res) ->
      data = ''
      res.on 'data', (chunk) ->
        data += chunk.toString()
      res.on 'end', () ->
        msg.reply data

