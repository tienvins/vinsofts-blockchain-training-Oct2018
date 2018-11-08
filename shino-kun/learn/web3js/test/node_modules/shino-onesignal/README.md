# Shino-onesignal

### Sends notifications to your users

This is an unofficial Node.js SDK for the [OneSignal Push Notification Service](https://onesignal.com/), which wraps their [REST API](https://documentation.onesignal.com/docs/server-api-overview).


## Installing

A step by step series of examples that tell you have to get a development env running

```js

npm install shino-onesignal

```


## Basic Usage

```js
const Shino = require('shino-onesignal')

const appid   = "YOUR_APP_ID",
      apikey  = "YOUR_API_REST_KEY";


const shino = new Shino(appid, apikey);

// variable
var id   = "YOUR_PLAYER_ID",
    ids  = ["YOUR_PLAYER_ID1", "YOUR_PLAYER_ID2", ...],
    tags = {
        key: 'user_id',
        value: 1
    },
    contents  = {
        body: "Message from Hoang Master",
        head: "Hello everyone",
        data: {
            notification_type: 1
        },
        url: 'http://shippy.yez.vn:1337'
    },
    dataEdit = {
        tags: {
            edit_by: "Hoang kun"
        }
        ....
    };


// Send based on OneSignal PlayerIds - Create notification
shino.toIds(contents, ids)

// Send based on filters/tags - Create notification
shino.toTags(contents, tags)

// Send to all subscribers - Create notification
shino.toAll(contents)

// View the details of a single OneSignal app
// Requires your OneSignal User Auth Key
// const shino = new Shino(appid, apikey, authkey);
shino.viewApp()
     .then(data => console.log(data) )
     .catch(e => console.log(e))

// View the details of all of your current OneSignal apps
// Requires your OneSignal User Auth Key
// const shino = new Shino(appid, apikey, authkey);
shino.viewApps()
     .then(data => console.log(data) )
     .catch(e => console.log(e))

// View the details of an existing device in one of your OneSignal apps
shino.viewDevice(id)
     .then(data => console.log(data) )
     .catch(e => console.log(e))


// Update an existing device in one of your OneSignal apps
shino.editDevice(dataEdit, id)
     .then(data => console.log(data) )
     .catch(e => console.log(e))

// View the details of multiple devices in one of your OneSignal apps
shino.viewDevices(start, limit)
     .then(data => console.log(data) )
     .catch(e => console.log(e))
     
// create notification with more options
shino.createNotification({
        contents: {
            contents: "Message from Hoang Master",
            headings:"Hello everybody"
        },
        specific: {
            include_player_ids: ids
        },
        attachments: {
            data: {
                notification_type: 2
            }
        }
    })
    .then(success => console.log(data))
    .catch( e => console.log(e));

```

### Available in Keys & IDs

* appId(string, required) - your OneSignal App ID

* restApiKey(string, required) - your OneSignal REST API Key

* authKey(string) - your OneSignal User Auth Key.

## More about 

* [contents](https://documentation.onesignal.com/v3.0/reference#section-content-language),
* [attachments](https://documentation.onesignal.com/v3.0/reference#section-attachments) 
* [specific](https://documentation.onesignal.com/v3.0/reference#section-send-to-specific-devices)

* [Server REST API Reference](https://documentation.onesignal.com/v5.0/reference)

## Versioning

```
Version 0.0.1

```

## Authors

* **Hoang Le** - *Initial work* - 

[Issue](https://github.com/hoangsnow9x/shino-onesignal/issues)



