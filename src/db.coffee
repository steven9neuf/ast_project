level = require 'level'
levelws = require 'level-ws'

module.exports = (paths) ->
	db = levelws level "#{__dirname}/../db"
