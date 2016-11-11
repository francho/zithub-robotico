# Description:
#   Jodo co, ¿qué pasa co?
#
# Author:
#   Francho

module.exports = (robot) ->
  leaveReplies = [
    'https://www.youtube.com/watch?v=zAo7fS_8a60',
    '¿qué pasa co?',
    'cooooooo!!!',
    'hey co',
    'jodo co',
    'chicooooo',
    'nada co',
    'noooooojodas co',
    'co, ¿y eso co?'
  ]

  robot.hear /\bco\b/im, (res) ->
    return if res.message.text.match(/^co \w/)
    res.reply res.random leaveReplies
