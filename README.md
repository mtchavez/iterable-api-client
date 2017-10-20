# Iterable API Gem

[![Gem](https://img.shields.io/gem/v/iterable-api-client.svg)](https://rubygems.org/gems/iterable-api-client)
[![build status](https://gitlab.com/mtchavez/iterable/badges/master/build.svg)](https://gitlab.com/mtchavez/iterable/commits/master)
[![coverage report](https://gitlab.com/mtchavez/iterable/badges/master/coverage.svg)](https://gitlab.com/mtchavez/iterable/commits/master)

Rubygem to interact with the [Iterable][iterable] API.

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

* [Campaigns](#campaigns)
  * [All](#campaigns-all)
  * [Create](#campaigns-create)
  * [Metrics](#campaigns-metrics)
  * [Child Campaigns](#campaigns-child)
* [Channels](#channels)
  * [All](#channels-all)
* [Commerce](#commerce)
  * [Track Purchase](#commerce-track-purchase)
  * [Update Cart](#commerce-update-cart)
* [Device](#device)
  * [Register Device Token](#device-register)
* [Email](#email)
  * [View](#email-view)
* [Email Templates](#email-templates)
  * [Get](#email-templates-get)
  * [Update](#email-templates-update)
  * [Upsert](#email-templates-upsert)
* [Experiments](#experiments)
  * [Metrics](#experiments-metrics)
* [Events](#events)
  * [For Email](#events-for-email)
  * [Track](#events-track)
  * [Track Push Open](#events-track-push-open)
* [Lists](#lists)
  * [All](#lists-all)
  * [Create](#lists-create)
  * [Delete](#lists-delete)
  * [Get Users](#lists-users)
  * [Subscribe](#lists-subscribe)
  * [Unsubscribe](#lists-unsubscribe)
* [Message Types](#message-types)
  * [All](#message-types-all)
* [Metadata](#metadata)
  * [Get](#metadata-get)
  * [List Keys](#metadata-list-keys)
  * [Delete](#metadata-delete)
  * [Get Key](#metadata-get-key)
  * [Remove Key](#metadata-remove-key)
  * [Add Key](#metadata-add-key)
* [Push Templates](#push-templates)
  * [Get](#push-templates-get)
  * [Update](#push-templates-update)
  * [Upsert](#push-templates-upsert)
* [Templates](#templates)
  * [All](#templates-all)
  * [Get](#templates-get)
* [Users](#users)
  * [Update](#users-update)
  * [Bulk Update](#users-bulk-update)
  * [Update Subscriptions](#users-update-subscriptions)
  * [Bulk Update Subscriptions](#users-bulk-update-subscriptions)
  * [For Email](#users-for-email)
  * [By User ID](#users-by-id)
  * [Get Fields](#users-get-fields)
  * [Update Email](#users-update-email)
  * [Delete](#users-delete)
  * [Delete By ID](#users-delete-by-id)
  * [Register Browser Token](#users-register-browser-token)
  * [Disable Device](#users-disable-device)
  * [Get Sent Messages](#users-get-messages)
* [Workflows](#workflows)
  * [Trigger](#workflows-trigger)

### [message types](#message-types)

#### [all](#message-types-all)

Endpoint: `GET /messageTypes`

```ruby
metadata = Iterable::MessageTypes.new
response = metadata.all
```

### [metadata](#metadata)

#### [get](#metadata-get)

Endpoint: `GET /metadata`

```ruby
metadata = Iterable::Metadata.new
response = metadata.get
```

#### [list keys](#metadata-list-keys)

Endpoint: `GET /metadata/{table}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.list_keys

# Next marker is thenext result set id which is returned by previous
# search if more hits exist
response = metadata_table.list_keys 'next-marker-id'
```

#### [delete](#metadata-delete)

Endpoint: `DELETE /metadata/{table}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.delete
```

#### [get key](#metadata-get-key)

Endpoint: `GET /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.get 'metadata-key'
```

#### [remove key](#metadata-remove-key)

Endpoint: `DELETE /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
response = metadata_table.remove 'metadata-key'
```

#### [add key](#metadata-add-key)

Endpoint: `PUT /metadata/{table}/{key}`

```ruby
metadata_table = Iterable::MetadataTable.new 'table-name'
value = { foo: 'bar', data: 'stuffs' }
response = metadata_table.add 'metadata-key', value
```

### [push templates](#push-templates)

#### [get](#push-templates-get)

Endpoint: `GET /templates/push/get`

```ruby
templates = Iterable::PushTemplates.new
# Additional template params to query by
params = { locale: 'en-US' }
response = templates.get 'template-id', params
```

#### [update](#push-templates-update)

Endpoint: `POST /templates/push/update`

```ruby
templates = Iterable::PushTemplates.new
# Additional template attrs to update
attrs = { name: 'Template', message: 'Template message'}
response = templates.update 'client-template-id', attrs
```

#### [upsert](#push-templates-upsert)

Endpoint: `POST /templates/push/upsert`

```ruby
templates = Iterable::PushTemplates.new
# Additional template attrs to upsert
attrs = { name: 'Template', message: 'Template message'}
response = templates.upsert 'client-template-id', attrs
```

### [templates](#templates)

#### [all](#templates-all)

Endpoint: `GET /templates`

```ruby
templates = Iterable::Templates.new
# Additional params to filter and search by
params = { templateType: Iterable::Templates::BLAST_TYPE, messageMedium: Iterable::MessageTypes::EMAIL_MEDIUM }
response = templates.all params
```

#### [get](#templates-get)

Endpoint: `GET /templates/getByClientTemplateId`

```ruby
templates = Iterable::Templates.new
response = templates.for_client_template_id 'client-template-id'
```

### [users](#users)

#### [update](#users-update)

Endpoint: `POST /users/update`

```ruby
users = Iterable::Users.new
# Additional attributes to send
attrs = { userID: 'custom-id' }
response = users.update 'user@example.com', attrs
```

#### [bulk update](#users-bulk-update)

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

#### [get sent messages](#users-get-messages)

Endpoint: `POST /users/update`

```ruby
users = Iterable::Users.new
# Additional params to filter and query by
params = { campaignId: 'custom-id', limit: 30 }
end_time = Time.now
start_time = end_time - (60 * 60* 24 * 7) # 7 days ago
response = users.sent_messages 'user@example.com', start_time, end_time, params
```

### [workflows](#workflows)

#### [trigger](#workflows-trigger)

Endpoint: `POST /workflows/triggerWorkflow`

```ruby
workflows = Iterable::Workflows.new
# Additional attributes to send
attrs = { listId: 'listId' }
response = workflows.trigger 'workflow-id', attrs
```

[docs]: http://www.rubydoc.info/gems/iterable-api-client
[iterable]: https://iterable.com
