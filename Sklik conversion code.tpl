___INFO___

{
  "displayName": "Sklik conversion code 2020-04-14",
  "description": "Sklik conversion code\nMore info about Sklik code\nhttps://napoveda.sklik.cz/mereni-uspesnosti/konverze/konverzni-kod/\nBy Marek Lecián",
  "securityGroups": [],
  "id": "cvt_temp_public_id",
  "type": "TAG",
  "version": 1,
  "brand": {
    "displayName": "",
    "id": "brand_dummy"
  },
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "help": "The number (e.g. 123456) from your conversion code... \n\"seznam_cId \u003d 123456;\"",
    "valueValidators": [
      {
        "enablingConditions": [],
        "errorMessage": "This must be a number",
        "type": "POSITIVE_NUMBER"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "displayName": "Sklik conversin ID",
    "simpleValueType": true,
    "name": "Sklik_seznam_cId",
    "type": "TEXT"
  },
  {
    "help": "The number (e.g. 123456) from your conversion code... \n\"seznam_value \u003d 123456;\"",
    "valueValidators": [
      {
        "enablingConditions": [],
        "errorMessage": "This must be a number",
        "type": "POSITIVE_NUMBER"
      },
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "displayName": "Sklik conversin value (optional)",
    "simpleValueType": true,
    "name": "Sklik_seznam_value",
    "type": "TEXT"
  },
  {
    "help": "The string (e.g. ABC123456) from your order Id ... \n\"seznam_orderId \u003d dfsfdsfdsfdsfds;\"",
    "displayName": "Sklik Order Id (optional)",
    "simpleValueType": true,
    "name": "Sklik_seznam_orderId",
    "type": "TEXT"
  },
  {
    "displayName": "Custom Variables",
    "name": "CustomVariables",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "type": "GROUP",
    "subParams": [
      {
        "displayName": "",
        "name": "CustomVarsTable",
        "simpleTableColumns": [
          {
            "valueValidators": [
              {
                "args": [
                  "^[a-zA-Z0-9_-]+$"
                ],
                "enablingConditions": [],
                "errorMessage": "Please only use characters: a-z, 0-9, _, -",
                "type": "REGEX"
              },
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "",
            "displayName": "Variable Name",
            "name": "VariableName",
            "isUnique": true,
            "type": "TEXT",
            "valueHint": "e.g.: user-logged-in"
          },
          {
            "macrosInSelect": true,
            "defaultValue": "",
            "displayName": "Custom Variable Value",
            "name": "Value",
            "type": "TEXT",
            "valueHint": "Choose a GTM Variable or type some value here"
          }
        ],
        "type": "SIMPLE_TABLE"
      },
      {
        "displayName": "Note: Create your own custom variables. It will be passed to Sklik as additional URL parameters. e.g. user-logged-in with value 1 will be passed as \u0026user-logged-in\u003d1",
        "name": "Explanation",
        "type": "LABEL"
      }
    ]
  },
  {
    "displayName": "Help and support",
    "name": "help",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "displayName": "https://napoveda.sklik.cz/mereni-uspesnosti/konverze/konverzni-kod/",
        "name": "label2",
        "type": "LABEL"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const encodeUriComponent = require('encodeUriComponent');
const getCookie = require('getCookieValues');
const getUrl = require('getUrl');
const getType = require('getType');
const log = require('logToConsole');
const query = require('queryPermission');
const sendPixel = require('sendPixel');

var url = getUrl();
var ConversionID = data.Sklik_seznam_cId;
var ConversionValue = data.Sklik_seznam_value;
var orderId = data.Sklik_seznam_orderId;
var newQuery = [];
var sid = getCookie('sid')[0];

if (getUrl('query').length > 0) { newQuery.push(getUrl('query')); }

for (var customVarRow in data.CustomVarsTable) {
  var customVar = data.CustomVarsTable[customVarRow];
  
  if (getType(customVar.Value) !== 'undefined' || customVar.Value !== '') {
    newQuery.push(customVar.VariableName+'='+customVar.Value);
  }
}

var newURL = url.split('?')[0];
if (newQuery.length > 0) {
  var newURL = newURL + '?' + newQuery.join('&');
}

if (getUrl('fragment').length > 0) {
  newURL = newURL + '#' + getUrl('fragment');
}

var src = "https://c.imedia.cz/conv?" + "id=" + ConversionID ;
if (ConversionValue) {src += "&value=" + ConversionValue;}
if (orderId)         {src += "&orderId=" + encodeUriComponent(orderId);}
if (sid)             {src += "&lsid=" + encodeUriComponent(sid); src += "&dsid=" + encodeUriComponent(sid);}
src += "&url="  + encodeUriComponent(newURL);

log('data =', data);
log('url = ', url);
log('newURL = ', newURL);
log('output url = ', src);

if (query('send_pixel', src)) {
  sendPixel(src);
}


// Call data.gtmOnSuccess when the tag is finished.
data.gtmOnSuccess();


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
        "publicId": "send_pixel",
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
                "string": "https://c.imedia.cz/retargeting*"
              },
              {
                "type": 1,
                "string": "https://c.imedia.cz/conv*"
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
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "sid"
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

scenarios:
- name: Untitled test 1
  code: |-
    const mockData = {
      // Mocked field values
    };

    // Call runCode to run the template's code.
    runCode(mockData);

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();


___NOTES___

Created on 25/09/2019, 20:13:52


