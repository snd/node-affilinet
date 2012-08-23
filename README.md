[![build status](https://secure.travis-ci.org/snd/node-affilinet.png)](http://travis-ci.org/snd/node-affilinet)
# affilinet

wraps some php code which talks to the affilinet soap webservices

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
```

### API

- `getShops(cb)` calls `cb` with an array of [shop objects](http://developer.affili.net/PortalData/1/Resources/pdfs/product_web_services_v3.0/GetShopListV3.pdf):
    - number `ShopId`
    - string `ShopLink` that is the link to the landing page of the shop
    - string `ShopTitle`
    - string `LastUpdate`
    - object `Logo`
        - number `Height`
        - number `Width`
        - string `LogoScale`
        - string `URL` that is the url of the logo
    - number `ProductCount`
    - number `ProgramId` that is the id of the programs this shop belongs to

- `getPrograms(cb)` calls `cb` with an array of [program objects](http://developer.affili.net/Portaldata/1/Resources/pdfs/Documentation_GetMyPrograms.pdf):
    - number `ProgramId`
    - string `ProgramTitle`
    - string `Description`
    - string `Url` that is the url of the landing page for the program
    - string `LaunchDate`
    - string `PartnershipStatus` that is the current status of the partnership. possible values are
        - `NotApplied`
        - `Paused`
        - `Active`
        - `Cancelled`
        - `Declined`
        - `Waiting`
    - object `CommissionRates`
        - object `PayPerLead`
            - number `MinRate`
            - number `MaxRate`
        - object `PayPerSale`
            - number `MinRate`
            - number `MaxRate`
        - object `PayPerClick`
            - number `MinRate`
            - number `MaxRate`
    - string `Limitations`

### License: MIT
