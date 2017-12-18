# require all the modules needed
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


#####################################################################
# Populate the database
#####################################################################
#####################################################################
# USERS
#####################################################################
# Create and save the user 1 into the database
user.save "user1", "password", "user1@gmail.com", (err) -> 
	throw err if err
	console.log "user 1 added"

# Create and save the user 2 into the database
user.save "user2", "password", "user2@gmail.com", (err) -> 
	throw err if err
	console.log "user 2 added"

#####################################################################
# METRICS
#####################################################################
# Save metrics for user 1 into the database
metrics.save "user1", [
	{timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:12}
	,
	{timestamp:(new Date '2015-12-18 14:00 UTC').getTime(), value:13}
], (err) ->
	throw err if err
console.log "metrics population for user 1 terminated"

# Save metrics for user 2 into the database
metrics.save "user2", [
	{timestamp:(new Date '2011-10-14 15:00 UTC').getTime(), value:8}
	,
	{timestamp:(new Date '2017-05-28 11:00 UTC').getTime(), value:5}
	,
	{timestamp:(new Date '2015-05-28 11:00 UTC').getTime(), value:9}
	,
	{timestamp:(new Date '2016-05-28 11:00 UTC').getTime(), value:1}
	,
	{timestamp:(new Date '2009-05-28 11:00 UTC').getTime(), value:15}
	,
	{timestamp:(new Date '2015-05-28 11:00 UTC').getTime(), value:7}
	,
	{timestamp:(new Date '2011-05-28 11:00 UTC').getTime(), value:13}
	,
	{timestamp:(new Date '2009-05-28 11:00 UTC').getTime(), value:4}
	,
	{timestamp:(new Date '2012-05-28 11:00 UTC').getTime(), value:10}
], (err) ->
	throw err if err
console.log "metrics population for user 2 terminated"

