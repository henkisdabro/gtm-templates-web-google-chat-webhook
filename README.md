# Google Chat Bot Tag Template for Google Tag Manager (web)

This is an **unofficial** Google Tag Manager Tag Template to assist with sending data to Google Chat (one-person chat, chat group or Space) via Webhook (Bot).

## How to setup a Webhook (Bot) in Google Chat

Steps:

1. Login to Google Chat on your browser, either through Gmail or the Google Chat app.
2. Click the name dropdown of either a (1) personal chat conversation between you and a person (or group) or (2) Space in which you want the message to go to.
3. Select "Manage webhooks".
4. Pick a suitable name of your "bot" and add a URL to your (optional) icon. 
5. Press Save and copy the webhook URL provided by the interface.
6. Inside GTM, open the Google Chat Webhook (bot) tag (that you've created using this template) and paste the webhook URL into the `Google Chat Webhook URL` field.

## Template Options

* **Google Chat Webhook URL** - Holds the value of the Google Chat Webhook URL
* **Google Chat Message Text** - Holds the message that will be sent to Google Chat by the App when the executes. This message box supports the ["Simple text Messages" format explained in Google's documentation](https://developers.google.com/chat/api/guides/message-formats/basic). You can use simple HTML tags and basic markdown-style text formats.
* **Use Advanced Variable** - When ticked the message can be replaced by a GTM Variable you define. This option expects a JSON object as specified in the ["Card Messages" format explained in Google's documentation](https://developers.google.com/chat/api/guides/message-formats/cards). A `Custom Javascript` variable type is recommended here.

## Message Types

Both of the message options above (simple or card messages), support the inclusion of `{{GTM variables}}` so you have the option to decorate your Google Chat bots' messages with details from your GTM implementation. An example would be to send a Google Chat Bot Message to a marketing team whenever a form submission on your site occurs (similar to how you would track this in e.g. Google Analytics or other marketing platforms) - in this example - including `Page Path`, `URL Query`, `Timestamp` or `Form ID` could be helpful information for this team.

### Simple Message Sample

In the example above, using the simple message box, a sample message format below: (ensure the needed variables are enabled and configured within GTM:

```shell
A form has been submitted on your website, here are the details:

Page Path: {{Page Path}}
URL Query: {{url - query}}
Event: {{Event}}
```

Result:

![screenshot][def1]

### Card Message Sample

The more advanced Card Message, can be built using the specifications in the link above for a more visually pleasing card in the arriving Google Chat bot message. You can add icons, buttons, images, maps, sections and more advanced information, contained within a JSON object, that you will need to add in a custom javascript variable inside GTM. Using the example above, the form submission example could be presented in a card message as such:

```javascript
function() {
  
  var textmessage = "A form has been submitted on your website.";
  var headertitle = "Form Submission occured on the Website";
  var headersubtitle = {{Page Hostname}};
  var widgetsarray = [
    {
      "keyValue": {
        "topLabel": "Page Path",
        "content": {{Page Path}},
        "icon": "MAP_PIN"
      }
    },
    {
      "keyValue": {
        "topLabel": "URL Query",
        "content": {{url - query}},
        "contentMultiline": "true",
        "icon": "DESCRIPTION"
      }
    },
    {
      "keyValue": {
        "topLabel": "Event",
        "content": {{Event}},
        "icon": "STAR"
      }
    }
  ];

  // Leave the below for this custom javascript variable to return the JSON object as its output.
  return {
    "text": textmessage, 
    "cards": [{
      "header": {
        "title": headertitle, 
        "subtitle": headersubtitle
      },
      "sections": [{
        "widgets": widgetsarray 
      }]
    }]
  };
}
```

Result:

![screenshot][def2]

#### Important Caveat

If any `{{variable}}` inside the JSON object - e.g. `{{url - query}}` - return `undefined` at runtime the JSON will fail and result in a blank/empty Google Chat bot message. To prevent this, consider open the `Format Value` section of each variable and tick the `Convert undefined to` option and set its value to a suitable string such as `(not set)` or `blank`.

![screenshot][def3]

## Author

Henrik Söderlund, with code kindly borrowed (forked) from Julian Juenemannn (https://measureschool.com) who provided the original scripts.

## Release

2 Feb 2023 - Change Ownership and Branding

25 Mar 2022 - Initial Release

[def1]: https://user-images.githubusercontent.com/477513/159207969-5958b1f6-e96c-4b12-aa03-53bc2a3f6f7e.png
[def2]: https://user-images.githubusercontent.com/477513/159208438-0bdc2853-55f9-4fbd-9990-9c053fc7ed84.png
[def3]: https://user-images.githubusercontent.com/477513/159208930-aded5875-3488-4b86-9c9b-a0455a361536.png
