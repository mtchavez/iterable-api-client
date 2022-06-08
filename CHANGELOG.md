## v0.4.0 - 2022-06-07

- Update request headers to include Iterable API token in accordance with API spec

## v0.3.2 - 2022-05-16

- Add `Iterable::Users#forget`

## v0.3.1 - 2020-05-11

- Fix `Catalog#create` update params

## v0.3.0 - 2020-04-06

- Add `Iterable::BulkCatalogItems`
- Add `Iterable::Catalogs`
- Add `Iterable::CatalogFieldMappings`
- Add `Iterable::CatalogItems`

## v0.2.1 - 2018-07-17

- `/email/target` endpaoint addes as `Iterable::Email#target

## v0.2.0 - 2017-10-27

### Campaigns

- `/campaigns` endpoint added as `Iterable::Campaigns#all`
- `/campaigns/create` endpoint added as `Iterable::Campaigns#create`
- `/campaigns/metrics` endpoint added as `Iterable::Campaigns#metrics`
- `/campaigns/recurring/{id}/childCampaigns` endpoint added as `Iterable::Campaigns#recurring`

### Channels

- `/channels` endpoint added as `Iterable::Channels#all`

### Commerce

- `/commerce/trackPurchase` endpoint added as `Iterable::Commerce#track_purchase`
- `/commerce/updateCart` endpoint added as `Iterable::Commerce#update_cart`

## Device

- `/users/registerDeviceToken` endpoint added as `Iterable::Device#register`

### Email

- `/email/viewInBrowser` endpoint added as `Iterable::Email#view`

### EmailTemplates

- `/templates/email/get` endpiont added as `Iterable::EmailTemplates#get`
- `/templates/email/update` endpiont added as `Iterable::EmailTemplates#update`
- `/templates/email/upsert` endpiont added as `Iterable::EmailTemplates#upsert`

### Events

- `/events/{email}` endpoint added as `Iterable::Events#for_email`
- `/events/track` endpoint added as `Iterable::Events#track`
- `/events/trackPushOpen` endpoint added as `Iterable::Events#track_push_open`

### Experiments

- `/experiments/metrics` endpiont added as `Iterable::Experiments#metrics`

### Export

- `/export/data.json` endpoint added as `Iterable::JsonExporter`
- `/export/data.csv` endpoint added as `Iterable::CsvExporter`

### Lists

- `/lists` endpoint added as `Iterable::Lists#all`
- Create a list with `Iterable::Lists#create`
- Delete a list with `Iterable::Lists#delete`
- `/lists/getUsers` with `Iterable::Lists#users`
- `/lists/subscribe` endpoint added as `Iterable::Lists#subscribe`
- `/lists/unsubscribe` endpoint added as `Iterable::Lists#unsubscribe`

### MessageTypes

- `/messageTypes` endpoint added as `Iterable::MessageTypes#all`

### Metadata

- `/metadata` endpoint added as `Iterable::Metadata#get`
- `/metadata/{table}` endpoint added as `Iterable::MetadataTable#list_keys`
- `/metadata/{table}` delete endpoint added as `Iterable::MetadataTable#delete`
- `/metadata/{table}/{key}` endpoint added as `Iterable::MetadataTable#get`
- `/metadata/{table}/{key}` delete endpoint added as `Iterable::MetadataTable#remove`
- `/metadata/{table}/{key}` put endpoint added as `Iterable::MetadataTable#add`

### PushTemplates

- `/templates/push/get` endpiont added as `Iterable::PushTemplates#get`
- `/templates/push/update` endpiont added as `Iterable::PushTemplates#update`
- `/templates/push/upsert` endpiont added as `Iterable::PushTemplates#upsert`

### Templates

- `/templates` endpoint added as `Iterable::Templates#all`
- `/templates/getByClientTemplateId` endpoint added as `Iterable::Templates#for_client_template_id`

### Users

- `/users/update` endpoint added as `Iterable::Users#update`
- `/users/bulkUpdate` endpoint added as `Iterable::Users#bulkUpdate`
- `/users/updateSubscriptions` endpoint added as `Iterable::Users#update_subscriptions`
- `/users/bulkUpdateSubscriptions` endpoint added as `Iterable::Users#bulk_update_subscriptions`
- `/users/{email}` endpoint added as `Iterable::Users#for_email`
- `/users/byUserId/{userId}` endpoint added as `Iterable::Users#for_id`
- `/users/getFields` endpoint added as `Iterable::Users#fields`
- `/users/updateEmail` endpoint added as `Iterable::Users#update_email`
- `/users/{email}` delete endpoint added as `Iterable::Users#delete`
- `/users/byUserId/{userId}` delete endpoint added as `Iterable::Users#delete_by_id`
- `/users/registerBrowserToken` endpoint added as `Iterable::Users#register_browser_token`
- `/users/disableDevice` endpoint added as `Iterable::Users#disable_device`
- `/users/getSentMessages` endpoint added as `Iterable::Users#sent_messages`

### Workflows

- `/workflows/triggerWorkflow` endpoint addes as `Iterable::Workflows#trigger`

## v0.1.0 - 2017-10-04

Initial gem setup without any functionality implemented.
