## Unreleased 0.1.0

### Campaigns

- `/campaigns` endpoint added as `Iterable::Campaigns#all`
- `/campaigns/create` endpoint added as `Iterable::Campaigns#create`
- `/campaigns/metrics` endpoint added as `Iterable::Campaigns#metrics`

### Channels

- `/channels` endpoint added as `Iterable::Channels#all`

### Events

- `/events/{emaail}` endpoint added for user events as `Iterable::Events#for_email`

### Lists

- `/lists` endpoint added as `Iterable::Lists#all`
- Create a list with `Iterable::Lists#create`
- Delete a list with `Iterable::Lists#delete`
- `/lists/getUsers` with `Iterable::Lists#users`