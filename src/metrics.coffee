module.exports = (db) ->
  # get(id, callback)
  # Get metrics
  # - id: metric's id
  # - callback: the callback function, callback(err, data)
  get: (metrics, callback) ->
    db.get "metrics:", (err, data) ->
      i = 1;
      metrics = {
        metrics: {}
      }
      rs = db.createReadStream()
      rs.on 'data' , (data) ->
        metric = 'metric' + i
        metrics.metrics[metric] = {
          key: data.key
          value: data.value
        }
        i++
      rs.on 'error', callback
      rs.on 'close', callback
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
    timestamp = (new Date '2015-12-18 14:00 UTC').getTime()
    id = 1
    ws.write({ key: "metrics:#{id}:#{timestamp}", value: "#{timestamp}" })
    for metric in metrics
      { timestamp, value } =  metric
      ws.write
        key: "metrics:#{id}:#{timestamp}"
        value: value
    ws.end()
