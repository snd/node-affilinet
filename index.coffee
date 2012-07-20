{execFile} = require 'child_process'

module.exports = class

    constructor: (@options) ->

    getShops: (cb) ->

        file = "#{__dirname}/php/get-shop-list-v3.php"

        args = [@options.publisherId, @options.productWebservicePassword]

        execFile file, args, (err, stdout, stderr) ->
            return cb new Error "stdout: #{stdout}, stderr: #{stderr}" if err?
            cb null, JSON.parse(stdout)?.Shops?.Shop

    getSalesForDayRange: (startDate, endDate, cb) ->
