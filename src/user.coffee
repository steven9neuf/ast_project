module.exports = (db) ->
	get: (username, callback) ->
		db.get "user:#{username}", (err, data) ->
			result = {}
			rs = db.createReadStream()
			rs.on 'data' , (data) ->
				if data.key.match /user.*/
					[user, username] = data.key.split ":"
					[password, email] = data.value.split ":"
					result =
						username: username
						password: password
						email: email
					console.log(result)
			rs.on 'error', () ->
			rs.on 'close', () ->
			rs.on 'end',  () ->
        console.log(result)
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
