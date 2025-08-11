___INFO___

{
  "type": "CLIENT",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sGTM robots.txt",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_SERVER___

const claimRequest      = require('claimRequest');      // přivlastní si request
const getRequestPath    = require('getRequestPath');    // vrátí část URL za doménou
const setResponseBody   = require('setResponseBody');   // zapíše tělo odpovědi
const setResponseHeader = require('setResponseHeader'); // nastaví HTTP hlavičku
const setResponseStatus = require('setResponseStatus'); // nastaví status code
const returnResponse    = require('returnResponse');    // odešle odpověď klientovi

/** Obslouží pouze přesný request /robots.txt */
if (getRequestPath() === '/robots.txt') {
  claimRequest();                                     // řekni sGTM „tušil jsem to“

  // obsah robots.txt
  const robotsTxt = 'User-agent: *\nDisallow: /';

  // sestav HTTP odpověď
  setResponseStatus(200);                             // 200 OK
  setResponseHeader('Content-Type', 'text/plain');    // MIME-type
  setResponseBody(robotsTxt);                         // tělo odpovědi
  returnResponse();                                   // pošli odpověď zpět
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "bodyAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "pathAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
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
        "publicId": "return_response",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_response",
        "versionId": "1"
      },
      "param": [
        {
          "key": "writeResponseAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "writeStatusAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "writeHeaderAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "writeBodyAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "writeHeadersAllowed",
          "value": {
            "type": 8,
            "boolean": true
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

Created on 11/08/2025, 16:02:03


