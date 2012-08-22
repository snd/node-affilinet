{execFile} = require 'child_process'

lift = (cb, f) -> (err, result) ->
    if err? then cb err else cb null, f result

module.exports = class

    constructor: (@options) ->

    _exec: (filename, args, cb) ->
        file = "#{__dirname}/php/#{filename}.php"

        execFile file, args, {maxBuffer: 5000*1024}, (err, stdout, stderr) ->
            return cb new Error "stdout: #{stdout}, stderr: #{stderr} err: #{err.toString()}" if err?
            cb null, JSON.parse stdout

    searchCreatives: (displayOptions, query, cb) ->
        args = [
            @options.publisherId
            @options.publisherWebservicePassword
            JSON.stringify displayOptions
            JSON.stringify query
        ]

        @_exec 'search-creatives', args, lift cb, (results) ->
            results?.CreativeCollection?.Creative || []

    getPrograms: (displayOptions, query, cb) ->
        args = [
            @options.publisherId
            @options.publisherWebservicePassword
            JSON.stringify displayOptions
            JSON.stringify query
        ]

        @_exec 'get-programs', args, lift cb, (results) ->
            results?.ProgramCollection?.Program || []

    getShops: (cb) ->
        args = [@options.publisherId, @options.productWebservicePassword]

        @_exec 'get-shop-list-v3', args, lift cb, (results) -> results?.Shops?.Shop

    getSalesLeadsBySubIdPerDay: (startDate, endDate, cb) ->
        args = [
            @options.publisherId
            @options.publisherWebservicePassword
            Math.floor(startDate.getTime() / 1000)
            Math.floor(endDate.getTime() / 1000)
        ]

        @_exec 'get-sales-leads-by-sub-id-per-day', args, lift cb, (results) ->
            results?.ArrayOfSalesLeadsBySubIdRecords?.SalesLeadsBySubIdRecords?.SalesLeadsBySubIdRecord
