___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Google Chat Webhook (Bot)",
  "brand": {
    "id": "github.com_cremedigital",
    "displayName": "cremedigital",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAB3UlEQVR4Ae3WAUQDURzH8YcQQoCiFCIpzHanEJ1QMqh7W7EtRYhg1a4gtKAIoKgUQdUtCKm2hQNAAAAIIEQYwtJrfwgqJb3XX/f78gMw/8+1awIhhBD6vZwgX5cqL0Uy157zV5ssL1vTQb5emC5VyqXTJe+xNsVg1VTJW6UHIkyUKXpx+mBuIwRDT9+7ZQhAqxr5OtAHMQVQ9E4wAaC4jl6MAAAAAAAAAAD8IOs04di+vIj58u6zRU/ch/YNR+lcx+agiu2MqvHL7IshADrenbF8qb6zpnyfkbWtD6jxq/kX7QCR89HG2mEVbgA0a9dV2gFip26cDuMIQF8H/QAFOcUUgAYAAAAAAAAAAAAAAAAAAAAAAPhyN4t92gFaN/rZAiSDuQbtAF17IywBUmVvS1C6AWid20OqeY0RQDF3SE/fGAAtejz23LMfp78Ibes+iN9PXGZn06Xc1EfLFJdkprjQId7SD2B8Qlf8AQAAAAAAAABPYQe4DTWA7ctseAEKiWsncOq4AVRqC3TO9t1920+kxVt8ACqxs2S/+G8RAIPjWQNUowU5LKgQAlStgpSCChOA/uP5A4TjeIr+5bwDoOPDUu+R20JveY2/vvhn+WM9teNX7LNkRPzDEELoFdXpxZA3On6zAAAAAElFTkSuQmCC"
  },
  "categories": [
    "CHAT"
  ],
  "description": "Send custom text messages or data to a Google Chat Conversion, Group or Space via Webhook (Bot).",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "webhookUrl",
    "displayName": "Google Chat Webhook URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "https://chat.googleapis.com.*"
        ],
        "errorMessage": "Please enter a valid Slack Webhook URL starting with https://hooks.slack.com/"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "https://chat.googleapis.com*",
    "help": "Add a Google Chat Webhook URL"
  },
  {
    "type": "TEXT",
    "name": "textMessage",
    "displayName": "Google Chat Message Text",
    "simpleValueType": true,
    "lineCount": 4,
    "textAsList": false,
    "enablingConditions": [
      {
        "paramName": "enableAdvanced",
        "paramValue": true,
        "type": "NOT_EQUALS"
      }
    ],
    "help": "Enter your (multi-line) message to be dispatched to your Google Chat Bot when the tag fires. Use {{Variables}} to fill your message dynamically with data from within GTM"
  },
  {
    "type": "CHECKBOX",
    "name": "enableAdvanced",
    "checkboxText": "Use advanced Variable",
    "simpleValueType": true,
    "help": "Use a GTM Variable that returns an Object to power the Snippet being display inside of the Google Chat. The object needs to be built according to https://developers.google.com/chat/how-tos/webhooks"
  },
  {
    "type": "SELECT",
    "name": "advancedVariable",
    "displayName": "",
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "enableAdvanced",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const log = require('logToConsole');
const queryPermission = require('queryPermission');
 
const postScriptUrl = 'https://cdn.jsdelivr.net/gh/cremedigital/gtm-templates-web-google-chat-webhook@main/googlechat-postRequest.js'; 
const endpoint = data.webhookUrl; //webhook URL

log(data);

const payload = data.enableAdvanced ? data.advancedVariable : {text: data.textMessage};

if (queryPermission('inject_script', postScriptUrl)) {
  injectScript(postScriptUrl, onSuccess, data.gtmOnFailure, postScriptUrl);
} else {
  log('postScriptUrl: Script load failed due to permissions mismatch.');
  data.gtmOnFailure();
}


function onSuccess() {
  callInWindow('sendData', payload, endpoint);
  data.gtmOnSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "sendData"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.jsdelivr.net/gh/cremedigital/gtm-templates-web-google-chat-webhook@main/googlechat-postRequest.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 3/18/2022, 1:44:16 PM


