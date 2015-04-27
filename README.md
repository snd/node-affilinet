# node-affilinet (DISCONTINUED!)

node-affilinet wraps some php code that talks to the affilinet soap webservices

node-affilinet calls out to the `php` command. it must be installed.

**this is very early work in progress**

### install

    npm install affilinet

### use

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

### api

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

- `getPrograms(displayOptions, query, cb)`
    - `displayOptions`
        - *required* number `CurrentPage`
        - *required* number `PageSize`
        - string `SortByEnum`
            - one of:
                - `ProgramId`
                - `ProgramTitle`
                - `ProgramLifetime`
            - default is `ProgramId`
        - string `SortOrderEnum`
            - one of:
                - `Ascending`
                - `Descending`
            - default is `Ascending`
    - `query`
        - array of integer `ProgramIds`
        - string `SearchString`
        - *required* array of string `PartnershipStatus` where each is one of:
            - `Active`
            - `Paused`
            - `Waiting`
            - `Refused`
            - `NoPartnership`
            - `Cancelled`
        - string `ProgramClassificationEnum` that is one of:
            - `All`
            - `Program`
            - `Campaign`
        - array of integer `ProgramCategoryIds`
        - array of string `TrackingMethods` where each is one of:
            - `Cookie`
            - `Session`
            - `SessionCookie`
        - array of string `SEMPolicyTypes` where each is one of:
            - `NotSet`
            - `Allowed`
            - `Restricted`
            - `NotAllowed`
        - integer `MinimumCookieLifetime`
        - integer `MaximumProgramLifetime`

    - calls `cb` with an array of [program objects](http://developer.affili.net/Portaldata/1/Resources/pdfs/Documentation_GetPrograms.pdf):
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

### license: MIT
