module.exports = (db) ->
	get: (username, callback) ->
		db.get "user:#{username}", (err, data) ->
			throw err if err
			callback null, null if data == null
			[username, email] = data.split ":"
			result = 
				username: username
				password: data.split(":")[0]
				email: email
			callback null, result

	save: (username, passwd, email, callback) ->
		ws = db.createWriteStream()
		ws.on 'error', callback 
		ws.on 'close', callback 
		ws.write
			key: "user:#{username}"
			value: "#{passwd}:#{email}"
		ws.end()

	remove: (username, callback) ->