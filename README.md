# affilinet

node wrapper for the affilinet php interface

**this is very early work in progress**

### Install

    npm install affilinet

### Use

```coffeescript

Affilinet = require 'affilinet'

affilinet = new Affilinet
    publisherId: '...'
    productWebservicePassword: '...'
    publisherWebservicePassword: '...'

affilinet.getShops (err, shops) ->
    throw err if err?
    console.log shops

    affilinet.getSalesForDayRange startDate, endDate, (err, sales) ->
        throw err if err?
        console.log sales
```

### License: MIT
