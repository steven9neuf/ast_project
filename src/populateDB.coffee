express = require 'express'
bodyparser = require 'body-parser'
morgan = require 'morgan'
session = require 'express-session'
SessionStore = require('level-session-store')(session)

level = require 'level'
levelws = require 'level-ws'

db = levelws level "#{__dirname}/../db"

metrics = require('./metrics')(db)
user = require('./user')(db)

metrics.save "user1", [
	{timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:12}
	,
	{timestamp:(new Date '2015-12-18 14:00 UTC').getTime(), value:13}
], (err) ->
	throw err if err
console.log "metrics population for user 1 terminated"


metrics.save "user2", [
	{timestamp:(new Date '2017-10-14 15:00 UTC').getTime(), value:8}
	,
	{timestamp:(new Date '2011-05-28 11:00 UTC').getTime(), value:5}
], (err) ->
	throw err if err
console.log "metrics population for user 2 terminated"

user.save "user1", "password", "user1@gmail.com", (err) -> 
	throw err if err
	console.log "user 1 added"