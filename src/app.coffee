express = require 'express'
bodyparser = require 'body-parser'
morgan = require 'morgan'
session = require 'express-session'
SessionStore = require('level-session-store')(session)

level = require 'level'
levelws = require 'level-ws'

db = levelws level "#{__dirname}/../db"

#db = require('./db') "#{__dirname}/../db/user"
metrics = require('./metrics')(db)
user = require('./user')(db)

app = express()

app.set 'port', '8888'
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'pug'



# Require middlewares
app.use bodyparser.json()
app.use bodyparser.urlencoded()
app.use morgan 'dev'
app.use session
	secret: "simple secret"
	store: new SessionStore './db/sessions'
	resave: true
	saveUnitialized: true

authCheck = (req, res, next) ->
	console.log req.session
	unless req.session.loggedIn == true
		res.redirect '/auth'
	else
		next()


##############
app.use '/', express.static "#{__dirname}/../public"

app.get '/', authCheck, (req, res) ->
	res.render 'index',
		text: "Hello #{req.session.username} !"


app.get '/hello/:name', (req, res) ->
	res.send "Hello #{req.params.name}"


##########
# Authentication
##########



app.get '/auth',(req, res) ->
	res.render 'auth'

app.post '/auth', (req, res) ->
	{username, password} = req.body
	user.get username, password, (err, user) ->
		throw next err if err
		unless password == user.password
			res.redirect '/auth'
		else
			req.session ?= {}
			req.session.loggedIn = true
			req.session.username = user.username
			console.log req.session
			res.redirect '/'


app.get '/logout', (req, res) ->
	req.session.destroy()
	console.log req.session
	res.redirect '/auth'



##########
# Metrics
##########

app.get '/metrics.json', (req, res) ->
	metrics.get req.session.username, (err, data) ->
		throw next err if err
		if data == null
			res.status(404).json 'Data not found'
		else
			res.status(200).json data

app.post '/deleteMetric/:metric', (req, res) ->
	console.log req.params.metric
	metrics.delete req.params.metric, (err) ->
		throw next err if err 
		res.status(200).send 'metric deleted'


app.post '/metrics.json/:id', (req, res) ->
	metrics.save req.params.id, req.body, (err) ->
		throw next err if err
		res.status(200).send 'metrics saved'



##########
# User routes
##########

user_router = express.Router()
#user_router.use authCheck


user_router.get '/user/:username', (req, res) ->
	user.get req.params.username, (err, user) ->
		throw next err if err
		if user == null
			res.status(404).send "user not found"
		else
			res.status(200).json user

user_router.post '/user', (req, res) ->
	{username, password, email} = req.body
	user.save username, password, email, (err) ->
		throw next err if err
		res.status(200).send "user saved"
		console.log res.session

app.use user_router


app.listen app.get('port'), () ->
	console.log "Server listening on #{app.get 'port'} !"
