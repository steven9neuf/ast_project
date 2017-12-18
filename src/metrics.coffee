module.exports = (db) ->
  # get(id, callback)
  # Get metrics
  # - id: metric's id
  # - callback: the callback function, callback(err, data)
  get: (metrics, callback) ->
    db.get "metrics:", (err, data) ->
      metrics = {
        metrics: []
      }
      rs = db.createReadStream()
      rs.on 'data' , (data) ->
        if data.key.match /metrics.*/
          metrics.metrics.push {
            key: data.key
            value: data.value
          }
      rs.on 'error', () ->
      rs.on 'close', () ->
      rs.on 'end',  () ->
        console.log(metrics)
        callback null, metrics

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
