# affilinet

node wrapper around some php code which talks to the affilinet soap webservices

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

- `getShops(cb)` calls `cb` with an array of shop objects:
    - Number `ShopId`
    - String `ShopLink` that is the link to the landing page of the shop
    - String `ShopTitle`
    - String `LastUpdate`
    - Object `Logo`
        - Number `Height`
        - Number `Width`
        - String `LogoScale`
        - String `URL` that is the url of the logo
    - Number `ProductCount`
    - Number `ProgramId` that is the id of the programs this shop belongs to

- [Specification](http://developer.affili.net/PortalData/1/Resources/pdfs/product_web_services_v3.0/GetShopListV3.pdf)

- `getPrograms(cb)` calls `cb` with an array of program objects:
    - Number `ProgramId`
    - String `ProgramTitle`
    - String `Description`
    - String `Url` that is the url of the landing page for the program
    - String `LaunchDate`
    - String `PartnershipStatus` that is the current status of the partnership. possible values are
        - `NotApplied`
        - `Paused`
        - `Active`
        - `Cancelled`
        - `Declined`
        - `Waiting`
    - Object `CommissionRates`
        - Object `PayPerLead`
            - Number `MinRate`
            - Number `MaxRate`
        - Object `PayPerSale`
            - Number `MinRate`
            - Number `MaxRate`
        - Object `PayPerClick`
            - Number `MinRate`
            - Number `MaxRate`
    - String `Limitations`
- [Specification](http://developer.affili.net/Portaldata/1/Resources/pdfs/Documentation_GetMyPrograms.pdf)

### License: MIT
