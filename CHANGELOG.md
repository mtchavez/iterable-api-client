## Unreleased 0.1.0

### Campaigns

- `/campaigns` endpoint added as `Iterable::Campaigns.new.all`
- `/campaigns/create` endpoint added as `Iterable::Campaigns.new.create`

### Lists

- `/lists` endpoint added as `Iterable::Lists.new.all`
- Create a list with `Iterable::Lists.new.create('foobar')`
- Delete a list with `Iterable::Lists.new.delete('1234')`
- `/lists/getUsers` with `Iterable::Lists.users('1234')`
