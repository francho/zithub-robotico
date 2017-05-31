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
inspect = require('util').inspect

module.exports = (robot) ->
  welcomeMsg = (nick) ->
    msg = """
Hola {nick}, soy Robotico...un bot, un amigo, un sirviente

Te recomiendo que antes de nada revises tu perfil y te pongas un avatar (nos gusta ver la cara a la gente para conocernos cuando coincidamos en algún sarao) y una pequeña bio para poder situarte.

Luego puedes presentarte en el canal #presentaciones para que sepan que has llegado, quién eres y a qué te dedicas.

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
    robot.logger.debug inspect(res.message)
    user = res.message.user
    robot.logger.debug "User enter #{user.name}"
    if Array.isArray robot.brain.data.nicks
      if user.name in robot.brain.data.nicks
        robot.logger.debug "Already know #{user.name}"
        return
      robot.messageRoom '#presentaciones', "Hola @#{user.name} ¿por qué no te presentas para que sepamos quién eres?"
      robot.messageRoom "@#{user.name}", welcomeMsg(user.name)
      add_nicks user.name
#      welcomeGif(user, user.name)

  robot.respond /la bienvenida/i, (msg) ->
    msg.reply welcomeMsg('')

