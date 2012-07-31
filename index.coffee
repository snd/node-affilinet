{execFile} = require 'child_process'

module.exports = class

    constructor: (@options) ->

    getPrograms: (displayOptions, query, cb) ->

        file = "#{__dirname}/php/get-programs.php"

        args = [
            @options.publisherId
            @options.publisherWebservicePassword
            JSON.stringify displayOptions
            JSON.stringify query
        ]

        execFile file, args, {maxBuffer: 5000*1024}, (err, stdout, stderr) ->
            return cb new Error "stdout: #{stdout}, stderr: #{stderr} err: #{err.toString()}" if err?
            programs = JSON.parse(stdout).ProgramCollection?.Program
            cb null, programs || []

    getShops: (cb) ->

        file = "#{__dirname}/php/get-shop-list-v3.php"

        args = [@options.publisherId, @options.productWebservicePassword]

        execFile file, args, (err, stdout, stderr) ->
            return cb new Error "stdout: #{stdout}, stderr: #{stderr} err: #{err.toString()}" if err?
            cb null, JSON.parse(stdout)?.Shops?.Shop

    getSalesForDayRange: (startDate, endDate, cb) ->

        file = "#{__dirname}/php/get-sales-leads-by-sub-id-per-day.php"

        args = [
            @options.publisherId
            @options.publisherWebservicePassword
            startDate.getTime()
            endDate.getTime()
        ]

        execFile file, args, (err, stdout, stderr) ->
            return cb new Error "stdout: #{stdout}, stderr: #{stderr} err: #{err.toString()}" if err?
            cb null, JSON.parse(stdout)
