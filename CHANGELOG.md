## Unreleased 0.1.0

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

### MessageTypes

- `/messageTypes` endpoint added as `Iterable::MessageTypes#all`

### Templates

- `/templates` endpoint added as `Iterable::Templates#all`
- `/templates/getByClientTemplateId` endpoint added as `Iterable::Templates#for_client_template_id`
