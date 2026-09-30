___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_voxelo_measurement_core",
  "version": 1,
  "securityGroups": [],
  "categories": [
    "ANALYTICS",
    "CONVERSIONS",
    "ATTRIBUTION"
  ],
  "displayName": "Voxelo Measurement core",
  "brand": {
    "id": "github.com_voxeloai_gtm-measurement-core",
    "displayName": "Voxelo"
  },
  "description": "Installs the Voxelo Measurement core on All Pages. Observes Voxelo Twin embeds, honors Consent Mode, and maps purchase / add_to_cart from the dataLayer. No second helper snippet.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "measurementId",
    "displayName": "Measurement ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^vxm_live_[A-Za-z0-9]+$"
        ]
      }
    ],
    "help": "Public Measurement ID from Voxelo Convert settings (starts with vxm_live_). Trigger this tag on All Pages. purchase and add_to_cart are read from dataLayer automatically. No second helper tag."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const copyFromWindow = require('copyFromWindow');
const createQueue = require('createQueue');
const makeString = require('makeString');
const getType = require('getType');

const measurementId = makeString(data.measurementId || '').trim();
// Day-one Gallery inject permission: must stay in lockstep with ___WEB_PERMISSIONS___.
// Do not expose a merchant-editable script URL: a new host forces every merchant to re-accept.
const scriptUrl = 'https://app.voxelo.ai/ea/measurement-core.js';

if (!measurementId) {
  data.gtmOnFailure();
  return;
}

const bootstrap = {
  measurementId: measurementId,
  adapter: 'gtm'
};

setInWindow('__voxeloMeasurementBootstrap', bootstrap, true);

const existingQueue = copyFromWindow('__voxeloConversionQueue');
if (getType(existingQueue) !== 'array') {
  setInWindow('__voxeloConversionQueue', [], false);
}
const pushToQueue = createQueue('__voxeloConversionQueue');
setInWindow('__voxeloPushConversion', function(signal) {
  pushToQueue(signal);
}, false);

injectScript(scriptUrl, data.gtmOnSuccess, data.gtmOnFailure, scriptUrl);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": [
            {
              "type": 1,
              "string": "https://app.voxelo.ai/ea/measurement-core.js"
            }
          ]
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
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": [
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
                  "string": "__voxeloMeasurementBootstrap"
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": false
                }
              ]
            },
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
                  "string": "__voxeloConversionQueue"
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": false
                }
              ]
            },
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
                  "string": "__voxeloPushConversion"
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": true
                },
                {
                  "type": 8,
                  "boolean": true
                }
              ]
            }
          ]
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
- name: Fails without Measurement ID
  code: |
    const mockData = {
      measurementId: '',
      gtmOnSuccess: () => fail('should not succeed'),
      gtmOnFailure: () => {}
    };
    mock('makeString', (v) => '' + (v === undefined || v === null ? '' : v));
    runCode(mockData);
- name: Injects production CDN with bootstrap
  code: |
    const mockData = {
      measurementId: 'vxm_live_example0001',
      gtmOnSuccess: () => {},
      gtmOnFailure: () => fail('should not fail')
    };
    mock('makeString', (v) => '' + (v === undefined || v === null ? '' : v));
    mock('setInWindow', () => {});
    mock('copyFromWindow', () => undefined);
    mock('createQueue', () => () => {});
    mock('getType', () => 'undefined');
    let injected;
    mock('injectScript', (url, onSuccess) => {
      injected = url;
      onSuccess();
    });
    runCode(mockData);
    assertThat(injected).isEqualTo('https://app.voxelo.ai/ea/measurement-core.js');


___NOTES___

Voxelo Measurement core for the Google Tag Manager Community Gallery.

Setup:
1. Add this tag from the Community Gallery.
2. Enter your Measurement ID from Voxelo Convert settings (vxm_live_…).
3. Trigger: All Pages.
4. Keep your existing GA4 / ecommerce tags pushing purchase and add_to_cart to
   dataLayer. No second Voxelo helper tag is required.
5. Optional: set data-voxelo-placement="embedded" or "pop-up" on Twin iframes.

This template loads https://app.voxelo.ai/ea/measurement-core.js. If a future
version adds a different script host, GTM will ask you to re-accept permissions.

Plain-script install is also available from Voxelo Convert settings if you do
not use GTM.


___HISTORY_CONSENT___

{
  "consentStatus": "CONSENT GRANTED",
  "consentRecords": [
    {
      "consentStatuses": {
        "ANALYTICS_STORAGE": "CONSENT GRANTED",
        "AD_STORAGE": "CONSENT GRANTED"
      },
      "consentPurpose": "Template Author Consent",
      "consentTime": "2026-09-28T15:00:00.000Z",
      "consentUser": "voxelo"
    }
  ]
}
