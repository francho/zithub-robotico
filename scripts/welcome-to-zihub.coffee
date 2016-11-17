# Description:
#   Welcome to Zithub.
#
# Configuration:
#   * A persistent brain store like hubot-redis-brain is highly recommended.
#
# Notes:
#   * Sends welcome as private message
#   * Based on welcome.coffee by Bob Silverberg <bob.silverberg@gmail.com>
#
# Commands:
#   hubot la bienvenida

# Author:
#   Francho

hubot = require 'hubot'

module.exports = (robot) ->
  welcomeMsg = (nick) ->
    msg = """
Hola {nick}, soy Robotico...un bot, un amigo, un sirviente

Te recomiendo que antes de nada revises tu perfil y te pongas un avatar (nos gusta ver la cara a la gente para conocernos cuando coincidamos en algún sarao).

Luego puedes presentarte en el canal #presentaciones para que sepan que has llegado.

Por aquí usamos la regla de los dos pies, así que echa un vistazo a los canales y únete a los de tu interés. En el momento que veas que no te aportan nada o que tu no puedes aportar nada puedes (debes) abandonar el canal y aquí no ha pasado nada.

Bienvenid@
"""
    msg.replace '{nick}', nick

  add_nicks = (nicks) ->
    robot.brain.data.nicks ||= []
    nicks = [nicks] unless Array.isArray nicks
    for nick in nicks
      unless nick in robot.brain.data.nicks
        robot.brain.data.nicks.push nick
        robot.logger.debug "Added nick: #{nick}"

  welcomeGif = (user, room) ->
    msg = new hubot.TextMessage(user, robot.name + ' gif me hello')
    msg.room = room
    robot.receive msg

  robot.brain.on 'loaded', =>
    robot.brain.data.nicks ||= []

  robot.enter (res) ->
    user = res.message.user
    robot.logger.debug "User enter #{user.name}"
    if Array.isArray robot.brain.data.nicks
      if user.name in robot.brain.data.nicks
        robot.logger.debug "Already know #{user.name}"
        return
#      robot.adapter.client.chat.postMessage(user.name, welcomeMsg(user.name))
      robot.messageRoom user.name, welcomeMsg(user.name)
      robot.messageRoom '#presentaciones', "Hola @#{user.name}"
      welcomeGif(user, 'presentaciones')
      add_nicks user.name

  robot.respond /la bienvenida/i, (msg) ->
#    msg.reply welcomeMsg('')
    msg.reply 'voyq'
    robot.adapter.client.chat.postMessage(msg.room, welcomeMsg(''))
