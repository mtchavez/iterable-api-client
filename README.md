# Iterable API Gem

[![Gem](https://img.shields.io/gem/v/iterable-api-client.svg)](https://rubygems.org/gems/iterable-api-client)
[![pipeline status](https://gitlab.com/mtchavez/iterable/badges/master/pipeline.svg)](https://gitlab.com/mtchavez/iterable/-/commits/master)
[![coverage report](https://gitlab.com/mtchavez/iterable/badges/master/coverage.svg)](https://gitlab.com/mtchavez/iterable/commits/master)

Rubygem to interact with the [Iterable][iterable] API.

[Source code][source] on [Gitlab].

## Installation

```ruby
gem install iterable-api-client
```

or with Bundler in your `Gemfile`

```ruby
gem 'iterable-api-client'
```

## Usage

### Documentation

Documentation can be found on [rubydoc][docs] or in this README

### API Documentation

The Iterable [API documentation][api-docs] can be a helpful reference for looking
up all the possible endpoint data interactions. The docs outline all the possible
parameters to each endpoints as well as custom data fields.

### Configuration

#### Global Config

Configure the gem with a default global configuration to use.

```ruby
Iterable.configure do |config|
  config.token = 'api-token'
end
```

### Config Object

If you have multiple tokens to use you can create a `Iterable::Config` object
with a different token from the global default and pass in on requests.

```ruby
# Creating a new config with a different token
conf = Iterable::Config.new(token: 'new-token')

# Example of using it with the campaigns endpoints
# which will then make API requests using the passed in config
campaigns = Iterable::Campaigns.new(config)
```

### Responses

Response objects will attempt to parse the API response as JSON using the `multi_json`
gem so you can have your own JSON parser handle the loading of responses.

You can access some of the response data for example:

```ruby
templates = Iterable::Templates.new
response = templates.all

# Check if the response code is a succesfull HTTP Code from 200-299
response.success?

# Get response code
response.code

# Body of response - will attempt to parse as JSON
response.body

# HTTP message
response.message

# The URI used to make the request for the response
reponse.uri
```

## API Endpoints

- [Bulk Catalog Items](#bulk-catalog-items)
  - [Create](#bulk-catalog-items-create)
  - [Delete](#bulk-catalog-items-delete)
- [Campaigns](#campaigns)
  - [All](#campaigns-all)
  - [Create](#campaigns-create)
  - [Metrics](#campaigns-metrics)
  - [Child Campaigns](#campaigns-child)
- [Catalog Field Mappings](#catalog-field-mappings)
  - [Get](#catalog-field-mappings-get)
  - [Update](#catalog-field-mappings-update)
- [Catalog Items](#catalog-items)
  - [All](#catalog-items-all)
  - [Create](#catalog-items-create)
  - [Update](#catalog-items-update)
  - [Get](#catalog-items-get)
  - [Delete](#catalog-items-delete)
- [Catalogs](#catalogs)
  - [Create](#catalogs-create)
  - [Delete](#catalogs-delete)
  - [Names](#catalogs-names)
- [Channels](#channels)
  - [All](#channels-all)
- [Commerce](#commerce)
  - [Track Purchase](#commerce-track-purchase)
  - [Update Cart](#commerce-update-cart)
- [Device](#device)
  - [Register Device Token](#device-register-token)
- [Email](#email)
  - [View](#email-view)
  - [Target](#email-target)
- [Email Templates](#email-templates)
  - [Get](#email-templates-get)
  - [Update](#email-templates-update)
  - [Upsert](#email-templates-upsert)
- [Events](#events)
  - [For Email](#events-for-email)
  - [Track](#events-track)
  - [Track Push Open](#events-track-push-open)
- [Experiments](#experiments)
  - [Metrics](#experiments-metrics)
- [Export](#export)
  - [JSON](#export-json)
  - [CSV](#export-csv)
- [In App](#in-app)
  - [Messages](#in-app-messages)
- [Lists](#lists)
  - [All](#lists-all)
  - [Create](#lists-create)
  - [Delete](#lists-delete)
  - [Get Users](#lists-users)
  - [Subscribe](#lists-subscribe)
  - [Unsubscribe](#lists-unsubscribe)
- [Message Types](#message-types)
  - [All](#message-types-all)
- [Metadata](#metadata)
  - [Get](#metadata-get)
  - [List Keys](#metadata-list-keys)
  - [Delete](#metadata-delete)
  - [Get Key](#metadata-get-key)
  - [Remove Key](#metadata-remove-key)
  - [Add Key](#metadata-add-key)
- [Push Templates](#push-templates)
  - [Get](#push-templates-get)
  - [Update](#push-templates-update)
  - [Upsert](#push-templates-upsert)
- [Templates](#templates)
  - [All](#templates-all)
  - [Get](#templates-get)
- [Users](#users)
  - [Update](#users-update)
  - [Bulk Update](#users-bulk-update)
  - [Update Subscriptions](#users-update-subscriptions)
  - [Bulk Update Subscriptions](#users-bulk-update-subscriptions)
  - [For Email](#users-for-email)
  - [By User ID](#users-by-id)
  - [Get Fields](#users-get-fields)
  - [Update Email](#users-update-email)
  - [Delete](#users-delete)
  - [Delete By ID](#users-delete-by-id)
  - [Register Browser Token](#users-register-browser-token)
  - [Disable Device](#users-disable-device)
  - [Get Sent Messages](#users-get-messages)
- [Workflows](#workflows)
  - [Trigger](#workflows-trigger)

### Bulk Catalog Items

**Beta access only** endpoint

#### Bulk Catalog Items Create

Endpoint: `POST /catalogs/{catalogName}/items`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::BulkCatalogItems.new(catalog)
# Hash of item id to item values
create_items = {
  '122343453' => {
    name: 'item name',
    status: 'open'
  }
}
response = catalog_items.create(create_items, replace_uploaded_fields_only: true)
 # Use replace_uploaded_fields_only as true to update fields
 # of existing items. Otherwise the default is to replace
 # existing items
```

#### Bulk Catalog Items Delete

Endpoint: `DELETE /catalogs/{catalogName}/items`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::BulkCatalogItems.new(catalog)
item_ids = ['12345', '12346', '12347']
response = catalog_items.create(item_ids)
```

### Campaigns

#### Campaigns All

Endpoint: `GET /campaigns`

```ruby
campaigns = Iterable::Campaigns.new
response = campaigns.all
```

#### Campaigns Create

Endpoint: `POST /campaigns/create`

```ruby
campaigns = Iterable::Campaigns.new
# List IDs to associate with the campaign
list_ids = [1234, 1235, 1236]
# Additional campaign attributes
attrs = { dataFields: { foo: 'bar' } }
response = campaigns.create 'name', 'template-id', list_ids, attrs
```

#### Campaigns Metrics

Endpoint: `GET /campaigns/metrics`

```ruby
campaigns = Iterable::Campaigns.new
campaign_ids = [754321, 4321, 3456]
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = campaigns.metrics campaign_ids, start_time, end_time
```

#### Campaigns Recurring

Endpoint: `GET /campaigns/recurring/{id}/childCampaigns`

```ruby
campaigns = Iterable::Campaigns.new
response = campaigns.recurring 'campaign-id'
```

### Catalogs

**Beta access only** endpoint

#### Catalogs Create

Endpoint: `POST /catalogs/{catalogName}`

```ruby
catalog = 'my-catalog'
catalogs = Iterable::Catalogs.new(catalog)
response = catalogs.create
```

#### Catalogs Delete

Endpoint: `DELETE /catalogs/{catalogName}`

```ruby
catalog = 'my-catalog'
catalogs = Iterable::Catalogs.new(catalog)
response = catalogs.delete
```

#### Catalogs Names

Endpoint: `GET /catalogs/{catalogName}`

```ruby
catalog = 'my-catalog'
catalogs = Iterable::Catalogs.new(catalog)
params = { page: 1, pageSize: 20 }
response = catalogs.names(params)
```

### Catalog Field Mappings

**Beta access only** endpoint

#### Catalog Field Mappings Get

Endpoint: `GET /catalogs/{catalogName}/fieldMappings`

```ruby
catalog = 'my-catalog'
catalog_field_mappings = Iterable::CatalogFieldMappings.new(catalog)
response = catalog_field_mappings.field_mappings
```

#### Catalog Field Mappings Update

Endpoint: `PUT /catalogs/{catalogName}/fieldMappings`

```ruby
catalog = 'my-catalog'
field_mappings = [{fieldName: 'test-field', fieldType: 'string'}]
catalog_field_mappings = Iterable::CatalogFieldMappings.new(catalog)
catalog_field_mappings.update(field_mappings)
```

### Catalog Items

**Beta access only** endpoint

#### Catalog Items All

Endpoint: `GET /catalogs/{catalogName}/items`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::CatalogItems.new(catalog)
response = catalog_items.all
```

#### Catalog Items Create

Endpoint: `PUT /catalogs/{catalogName}/items/{itemId}`

```ruby
catalog = 'my-catalog'
item_id = '1234-abcd-1234-abcd'
catalog_items = Iterable::CatalogItems.new(catalog, item_id)
item_attrs = { name: 'item name', status: 'open' }
response = catalog_items.create(item_attrs)
```

#### Catalog Items Update

Endpoint: `PATCH /catalogs/{catalogName}/items/{itemId}`

```ruby
catalog = 'my-catalog'
item_id = '1234-abcd-1234-abcd'
catalog_items = Iterable::CatalogItems.new(catalog, item_id)
item_attrs = { name: 'item name', status: 'open' }
response = catalog_items.update(item_attrs)
```

#### Catalog Items Get

Endpoint: `GET /catalogs/{catalogName}/items/{itemId}`

```ruby
catalog = 'my-catalog'
item_id = '1234-abcd-1234-abcd'
catalog_items = Iterable::CatalogItems.new(catalog, item_id)
response = catalog_items.get
```

#### Catalog Items Delete

Endpoint: `DELETE /catalogs/{catalogName}/items/{itemId}`

```ruby
catalog = 'my-catalog'
item_id = '1234-abcd-1234-abcd'
catalog_items = Iterable::CatalogItems.new(catalog, item_id)
response = catalog_items.delete
```

### Catalogs

**Beta access only** endpoint

#### Catalogs Create

Endpoint: `POST /catalogs/{catalogName}`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::Catalogs.new(catalog)
response = catalog_items.create
```

#### Catalogs Delete

Endpoint: `DELETE /catalogs/{catalogName}`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::Catalogs.new(catalog)
response = catalog_items.delete
```

#### Catalogs Names

Endpoint: `GET /catalogs/{catalogName}/names`

```ruby
catalog = 'my-catalog'
catalog_items = Iterable::Catalogs.new(catalog)
params = { page: 1, pageSize: 20 }
response = catalog_items.names(params)
```

### Channels

#### Channels All

Endpoint: `GET /channels`

```ruby
channels = Iterable::Channels.new
response = channels.all
```

### Commerce

#### Commerce Track Purchase

Endpoint: `POST /commerce/trackPurchase`

```ruby
# Set up items to track
items = [{
  id: 'abcd-1234-hjkl-4321',
  name: 'Mustard',
  price: 34.0,
  quantity: 13
}]
# Calculate total of items i.e. 34.0
total = items.reduce(0) { |total, item| total += item.fetch(:price, 0.0) }
# Gather user information for purchase
user = { userId: '42', email: 'user@example.com' }

commerce = Iterable::Commerce.new
response = commerce.track_purchase total, items, user
```

#### Commerce Update Cart

Endpoint: `POST /commerce/updateCart`

```ruby
# Items to update the user's cart with
items = [{
  id: 'abcd-1234-hjkl-4321',
  name: 'Mustard',
  price: 34.0,
  quantity: 13
}]
# User of the cart you want to update
user = { userId: '42', email: 'user@example.com' }

commerce = Iterable::Commerce.new
response = commerce.update_cart items, user
```

### Device

#### Device Register Token

Endpoint: `POST /users/registerDeviceToken`

```ruby
data_fields = { some: 'data', fields: 'here' }
device = Device.new 'token', 'mobile-push-app', Iterable::Device::APNS, data_fields
device.register 'foo@example.com'

# Can pass in a user ID as well
device.register 'user@example.com', '42'
```

### Email

#### Email View

Endpoint: `GET /email/viewInBrowser`

```ruby
email = Iterable::Email.new
response = email.view 'user@example.com', 'message-id'
```

#### Email Target

Endpoint: `GET /email/target`

```ruby
email = Iterable::Email.new
# User email and campaign to target
response = email.target 'user@example.com', 42

# Can pass in more attributes like dataFields
response = email.target 'user@example.com', 42, { dataFields: { first_name: 'Sally' } }
```

### Email Templates

#### Email Templates Get

Endpoint: `GET /templates/email/get`

```ruby
templates = Iterable::EmailTemplates.new
response = templates.get 'template-id'
```

#### Email Templates Update

Endpoint: `POST /templates/email/update`

```ruby
templates = Iterable::EmailTemplates.new
# Additional template attributes
attrs = { metadata: {}, name: 'name', fromEmail: 'co@co.co' }
response = templates.update 'template-id', attrs
```

#### Email Templates Upsert

Endpoint: `POST /templates/email/update`

```ruby
templates = Iterable::EmailTemplates.new
# Additional template attributes
attrs = { metadata: {}, name: 'name', fromEmail: 'co@co.co' }
response = templates.upsert 'client-template-id', attrs
```

### Events

#### Events for Email

Endpoint: `GET /events/{email}`

```ruby
events = Iterable::Events.new
# Default limit of 30
response = events.for_email 'user@example.com'
```

#### Events Track

Endpoint: `POST /events/track`

```ruby
events = Iterable::Events.new
# Any aditional attributes for the event
attrs = { campaignId: 42, dataFields: {} }
response = events.track 'event-name', 'user@example.com', attrs
```

#### Events Track Push Open

Endpoint: `GET /events/{email}`

```ruby
events = Iterable::Events.new
response = events.for_email 'user@example.com'
campaign_id = 42
message_id = 123
# Any aditional attributes for the event
attrs = { dataFields: {} }
response = events.track_push_open campaign_id, message_id, 'user@example.com', attrs
```

### Experiments

#### Experiments Metrics

Endpoint: `GET /experiments/metrics`

```ruby
experiment_ids = [1, 2, 3, 4]
experiments = Iterable::Experiments.new experiment_ids
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = experiments.metrics campaign_ids, start_time, end_time
```

### Export

#### Export JSON

Endpoint: `GET /export/data.json`

```ruby
exporter = Iterable::JsonExporter.new Iterable::Export::EMAIL_SEND_TYPE

# Export with an iterable range
response = exporter.export_range Iterable::Export::BEFORE_TODAY

# Export with a custom time range
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = exporter.export start_time, end_time
```

#### Export CSV

Endpoint: `GET /export/data.csv`

```ruby
exporter = Iterable::CsvExporter.new Iterable::Export::EMAIL_SEND_TYPE

# Export with an iterable range
response = exporter.export_range Iterable::Export::BEFORE_TODAY

# Export with a custom time range
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = exporter.export start_time, end_time
```

### In App

#### In App Messages

Endpoint: `GET /inApp/getMessages`

```ruby
in_app = Iterable::InApp.new

# Get messages for a user by email
email = 'user@example.com'
response = in_app.messages_for_email email, count: 10

# Get messages for a user by user_id
email = 'user@example.com'
response = in_app.messages_for_user_id 42, count: 2

# Pass in query parameters
email = 'user@example.com'
attrs = { 'platform' => 'iOS' }
response = in_app.messages_for_email: email, attrs
```

### Lists

#### Lists All

Endpoint: `GET /lists`

```ruby
lists = Iterable::Lists.new
response = lists.all
```

#### Lists Create

Endpoint: `POST /lists`

```ruby
lists = Iterable::Lists.new
response = lists.create 'list-name'
```

#### Lists Delete

Endpoint: `DELETE /lists/{listId}`

```ruby
lists = Iterable::Lists.new
response = lists.delete 'list-id'
```

#### Lists Get Users

Endpoint: `GET /lists/getUsers`

```ruby
lists = Iterable::Lists.new
response = lists.users 'list-id'
```

#### Lists Subscribe

Endpoint: `POST /lists/subscribe`

```ruby
lists = Iterable::Lists.new
subscribers = [
	{ email: 'user@example.com', dataFields: {}, userId: '42' }
]
response = lists.subscribe 'list-id', subscribers
```

#### Lists Unsubscribe

Endpoint: `POST /lists/unsubscribe`

```ruby
lists = Iterable::Lists.new
subscribers = [
	{ email: 'user@example.com', dataFields: {}, userId: '42' }
]
response = lists.unsubscribe 'list-id', subscribers
```

### Message Types

#### Message Types All

Endpoint: `GET /messageTypes`

```ruby
metadata = Iterable::MessageTypes.new
response = metadata.all
```

### Metadata

#### Metadata Get

Endpoint: `GET /metadata`

```ruby
metadata = Iterable::Metadata.new
response = metadata.get
```

#### Metadata List Keys

Endpoint: `GET /metadata/{table}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.list_keys

# Next marker is thenext result set id which is returned by previous
# search if more hits exist
response = metadata_table.list_keys 'next-marker-id'
```

#### Metadata Delete Key

Endpoint: `DELETE /metadata/{table}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.delete
```

#### Metadata Get Key

Endpoint: `GET /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.get 'metadata-key'
```

#### Metadata Remove Key

Endpoint: `DELETE /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.remove 'metadata-key'
```

#### Metadata Add Key

Endpoint: `PUT /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
value = { foo: 'bar', data: 'stuffs' }
response = metadata_table.add 'metadata-key', value
```

### Push Templates

#### Push Templates Get

Endpoint: `GET /templates/push/get`

```ruby
templates = Iterable::PushTemplates.new
# Additional template params to query by
params = { locale: 'en-US' }
response = templates.get 'template-id', params
```

#### Push Templates Update

Endpoint: `POST /templates/push/update`

```ruby
templates = Iterable::PushTemplates.new
# Additional template attrs to update
attrs = { name: 'Template', message: 'Template message'}
response = templates.update 'client-template-id', attrs
```

#### Push Templates Upsert

Endpoint: `POST /templates/push/upsert`

```ruby
templates = Iterable::PushTemplates.new
# Additional template attrs to upsert
attrs = { name: 'Template', message: 'Template message'}
response = templates.upsert 'client-template-id', attrs
```

### Templates

#### Templates All

Endpoint: `GET /templates`

```ruby
templates = Iterable::Templates.new
# Additional params to filter and search by
params = { templateType: Iterable::Templates::BLAST_TYPE, messageMedium: Iterable::MessageTypes::EMAIL_MEDIUM }
response = templates.all params
```

#### Templates Get

Endpoint: `GET /templates/getByClientTemplateId`

```ruby
templates = Iterable::Templates.new
response = templates.for_client_template_id 'client-template-id'
```

### Users

#### Users Update

Endpoint: `POST /users/update`

```ruby
users = Iterable::Users.new
# Additional attributes to send
attrs = { userID: 'custom-id' }
response = users.update 'user@example.com', attrs
```

#### Users Bulk Update

Endpoint: `POST /users/bulkUpdate`

```ruby
users = Iterable::Users.new
# Array of users to update by email with additional
# fields if needed
users = [
	{ email: 'user@example.com', userID: 'custom-id' }
]
response = users.bulk_update users
```

#### Users Update Subscriptions

Endpoint: `POST /users/updateSubscriptions`

```ruby
users = Iterable::Users.new
# Additional attributes to send
attrs = { userID: 'custom-id' }
response = users.update_subscriptions 'user@example.com', attrs
```

#### Users Bulk Update Subscriptions

Endpoint: `POST /users/bulkUpdateSubscriptions`

```ruby
users = Iterable::Users.new
# Array of users to update by email with additional
# fields if needed
users = [
	{ email: 'user@example.com', userID: 'custom-id' }
]
response = users.bulk_update_subscriptions users
```

#### Users For Email

Endpoint: `GET /users/{email}`

```ruby
users = Iterable::Users.new
response = users.for_email 'user@example.com'
```

#### Users For ID

Endpoint: `GET /users/byUserID/{userID}`

```ruby
users = Iterable::Users.new
response = users.for_id '42'
```

#### Users Get Fields

Endpoint: `GET /users/getFields`

```ruby
users = Iterable::Users.new
response = users.fields
```

#### Users Update Email

Endpoint: `POST /users/updateEmail`

```ruby
users = Iterable::Users.new
response = users.update_email 'old-email@me.com', 'new-email@email.me'
```

#### Users Delete

Endpoint: `DELETE /users/{email}`

```ruby
users = Iterable::Users.new
response = users.delete 'user@example.com'
```

#### Users Delete By ID

Endpoint: `DELETE /users/byUserId/{userID}`

```ruby
users = Iterable::Users.new
response = users.delete_by_id '42'
```

#### Users Register Browser Token

Endpoint: `POST /users/registerBrowserToken`

```ruby
users = Iterable::Users.new
# Additional attrs to associate with token
attrs = { userID: '42' }
response = users.register_browser_token 'user@example.com', 'the-token', attrs
```

#### Users Disable Device

Endpoint: `POST /users/registerBrowserToken`

```ruby
users = Iterable::Users.new
response = users.disable_device 'the-token', 'user@example.com'

# Optionally can use a user ID over email
response = users.disable_device 'the-token', nil, '42'
```

#### Users Get Sent Messages

Endpoint: `POST /users/update`

```ruby
users = Iterable::Users.new
# Additional params to filter and query by
params = { campaignId: 'custom-id', limit: 30 }
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = users.sent_messages 'user@example.com', start_time, end_time, params
```

### Workflows

#### Workflows Trigger

Endpoint: `POST /workflows/triggerWorkflow`

```ruby
workflows = Iterable::Workflows.new
# Additional attributes to send
attrs = { listId: 'listId' }
response = workflows.trigger 'workflow-id', attrs
```

[api-docs]: https://api.iterable.com/api/docs
[docs]: http://www.rubydoc.info/gems/iterable-api-client
[gitlab]: https://gitlab.com
[iterable]: https://iterable.com
[source]: https://gitlab.com/mtchavez/iterable
