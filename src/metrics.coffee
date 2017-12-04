module.exports = (db) ->
  # get(id, callback)
  # Get metrics
  # - id: metric's id
  # - callback: the callback function, callback(err, data)
  get: (metrics, callback) ->
    console.log metrics, callback
    db.get 'metrics:1:1383573600000', (err, data) ->
			throw err if err
			callback null, null if data == null
			result =
				key: data.key
				value: data.value
			callback null, result





    #db.get "metrics:#{key}", (err, data) ->
			#throw err if err
			#callback null, null if data == null
			#result =
			#	key: data.key
			#	value: data.value
      #callback null, result
    #rs = db.createReadStream()
    #rs.on 'data' , (data) ->
    #	console.log(data.key, '=', data.value)
    #rs.on 'error', callback
    #rs.on 'close',  callback
    #rs.on 'end',  callback

  #get: (callback) ->
  #  callback null, [
  #    timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:12
  #  ,
  #      timestamp:(new Date '2013-11-04 14:30 UTC').getTime(), value:15
  #  ]



  # save(id, metrics, callback)
  # Save given metrics
  # - id: metric id
  # - metrics: an array of { timestamp, value }
  # - callback: the callback function
  save: (id, metrics, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    #timestamp = (new Date '2013-11-04 14:00 UTC').getTime()
    #id = 2
    #ws.write({ key: "metrics:#{id}:#{timestamp}", value: "#{timestamp}" })
    for metric in metrics
      { timestamp, value } =  metric
      ws.write
        key: "metrics:#{id}:#{timestamp}"
        value: value
    ws.end()
