# Dotcom Distribution Endpoint

#### Connection Parameters

| Name | Value | example |
| :----| :-----| :------ |
| dotcom_api_key | Api Key | ertewrt |
| dotcom_password | Password | commerce |

### Add Shipments webhook

Send shipment details to Dotcom Distribution on completion

| Name | Value | example |
| :----| :-----| :------ |
| dotcom_shipping_lookup | Spree to Dotcom Distribution shipping methods' mapping | [{ 'UPS Ground (USD)' => '03' }] |

### Get Shipments webhooks

* Track shipment dispatches from Dotcom Distribution

| Name | Value | example |
| :----| :-----| :------ |
| dotcom_last_polling_datetime | Timestamp for polling shipments | 2014-01-29T03:14:07+00:00 |
