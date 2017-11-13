module.exports = (db) ->
  # get(id, callback)
  # Get metrics 
  # - id: metric's id 
  # - callback: the callback function, callback(err, data)
  get: (id, callback) ->
    rs = db.createReadStream()
    rs.on 'error', callback
    rs.on 'data' , (data) ->
    	callback null, data.value
    rs.on 'close', callback

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
    for metric in metrics 
      { timestamp, value } =  metric
      ws.write 
        key: "metrics:#{id}:#{timestamp}"
        value: value
    ws.end()


