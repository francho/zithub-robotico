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
# Author:
#   Francho

hubot = require 'hubot'

module.exports = (robot) ->
  welcomeMsg = (nick) ->
    msg = """
Hola {nick}, soy Robotico...un bot, un amigo, un sirviente

Te recominedo que antes de nada revises tu perfil y te pongas un avatar (nos gusta ver la cara a la gente para conocernos cuando coincidamos en algún sarao), luego puedes presentarte en el canal #general para que sepan que has llegado.

Por aquí usamos la regla de los dos pies, así que te recomiendo que eches un vistazo a los canales y te unas a los de tu interés. En el momento que veas que no te aportan nada o que tu no puedes aportar nada puedes (debes) abandonar el canal y aquí no ha pasado nada.

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

  robot.brain.on 'loaded', =>
    robot.brain.data.nicks ||= []

  saluteWithRandomGif = (res) ->
    msg = new hubot.TextMessage(res.message.user, robot.name + ' gif me hello')
    robot.receive msg

  robot.enter (res) ->
    user = res.message.user
    robot.logger.debug "User enter #{user.name}"
    if Array.isArray robot.brain.data.nicks
      if user.name in robot.brain.data.nicks
        robot.logger.debug "Already know #{user.name}"
        return
      add_nicks user.name
      robot.messageRoom user.name, welcomeMsg(user.name)
      saluteWithRandomGif res
