## Unreleased

### Campaigns

- `/campaigns` endpoint added as `Iterable::Campaigns#all`
- `/campaigns/create` endpoint added as `Iterable::Campaigns#create`
- `/campaigns/metrics` endpoint added as `Iterable::Campaigns#metrics`

### Channels

- `/channels` endpoint added as `Iterable::Channels#all`

### EmailTemplates

- `/templates/email/get` endpiont added as `Iterable::EmailTemplates#get`
- `/templates/email/update` endpiont added as `Iterable::EmailTemplates#update`
- `/templates/email/upsert` endpiont added as `Iterable::EmailTemplates#upsert`

### Events

- `/events/{emaail}` endpoint added for user events as `Iterable::Events#for_email`

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
- `/users/{email}` endpoint added as `Iterable::Users#for_email`
- `/users/byUserId/{userId}` endpoint added as `Iterable::Users#for_id`
- `/users/getFields` endpoint added as `Iterable::Users#fields`
- `/users/updateEmail` endpoint added as `Iterable::Users#update_email`
- `/users/{email}` delete endpoint added as `Iterable::Users#delete`
- `/users/byUserId/{userId}` delete endpoint added as `Iterable::Users#delete_by_id`
- `/users/registerBrowserToken` endpoint added as `Iterable::Users#register_browser_token`

### Workflows

- `/workflows/triggerWorkflow` endpoint addes as `Iterable::Workflows#trigger`

## v0.1.0 - 2017-10-04

Initial gem setup without any functionality implemented.
