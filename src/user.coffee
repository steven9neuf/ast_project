module.exports = (db) ->

	# get(username_sent, password_sent, callback)
	# Get the user which username and password match with the sent parameters
	# - username_sent : sent username by the auth form
	# - password_sent : sent password by the auth form
	# - callback : callback function
	get: (username_sent, password_sent, callback) ->
		db.get "user:#{username_sent}", (err, data) ->
			result = {}
			rs = db.createReadStream()
			rs.on 'data' , (data) ->
				[user, username] = data.key.split ":"
				[password, email] = data.value.split ":"
				if username == username_sent && password == password_sent
					result =
						username: username
						password: password
						email: email
			rs.on 'error', () ->
			rs.on 'close', () ->
			rs.on 'end',  () ->
        		callback null, result

    # save(username, passwd, email, callback)
	# Save the user into the database
	# - username : the username
	# - passwd : the password
	# - email : the email
	# - callback : callback function
	save: (username, passwd, email, callback) ->
		ws = db.createWriteStream()
		ws.on 'error', callback
		ws.on 'close', callback
		ws.write
			key: "user:#{username}"
			value: "#{passwd}:#{email}"
		ws.end()