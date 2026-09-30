# Voxelo Measurement core

Google Tag Manager template for **Voxelo Convert** Embed analytics.

Install once on **All Pages**. The tag loads the Measurement core, observes
Voxelo Twin embeds on your site, honors Google Consent Mode, and maps
`purchase` / `add_to_cart` from your existing `dataLayer`. No second Voxelo
helper tag is required.

## Requirements

- A Voxelo organization with a live **Measurement ID** (`vxm_live_…`) from
  Convert / Settings
- Your Twin embeds on the pages you want measured
- Existing GA4 (or equivalent) ecommerce tags that push `purchase` and
  `add_to_cart` to `dataLayer` when those events happen

## Setup

1. In Google Tag Manager, open **Templates** → **Search Gallery** (or import
   this template) and add **Voxelo Measurement core**.
2. Create a new tag from the template.
3. Enter your **Measurement ID** from Voxelo Convert settings.
4. Set the trigger to **All Pages** (or your equivalent sitewide trigger).
5. Publish the container.

When you first add the template, GTM will ask you to accept its permissions,
including loading the script from `https://app.voxelo.ai/ea/measurement-core.js`.

## What it measures

- Viewable **Impressions** and **Launches** of Voxelo Twins
- Shopper **Engagement** and **Dwell**
- **Conversion** events when your site already fires `purchase` /
  `add_to_cart` on `dataLayer`

The Twin iframe still works if this tag is not installed; Convert simply will
not measure until it is.

## Placement (optional)

For clearer reporting, mark how each Twin is shown:

| Attribute | Value | Meaning |
|-----------|--------|---------|
| `data-voxelo-placement` | `embedded` | Twin is in the page layout |
| `data-voxelo-placement` | `pop-up` | Twin opens on click / modal |

Put the attribute on the viewer iframe (or the control that opens a pop-up).
Undeclared installs still measure; rates are not split by placement.

## Consent

With this Gallery install, the Measurement core follows **Google Consent Mode**
storage signals (`ad_storage` / `analytics_storage`). Until consent is granted,
identified measurement (Attribution cookie, identified Impression / Engagement)
does not run; the Twin still displays.

## Permissions and updates

This template loads:

`https://app.voxelo.ai/ea/measurement-core.js`

If Voxelo ever adds a **new script host** to the template, GTM will ask you to
**re-accept** the template permissions before that update applies. That is
normal for Community Gallery templates.

## Other install options

If you do not use GTM, Voxelo also provides a plain-script snippet and Custom
HTML fallback in Convert settings. Behaviour is the same Measurement core;
only the install path differs.

## Support

- Product: [voxelo.ai](https://voxelo.ai)
- In-app Help: Convert proof playbook and Embed analytics FAQ in your Voxelo
  dashboard
- Issues with this template: use this repository’s GitHub Issues
