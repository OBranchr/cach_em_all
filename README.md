# CachEmAll

CachEmAll is a Rails :four: gem which aims to make the use of Rails 4's fragment caching even easier. Based on the [official documentation's tip](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching) of counting and getting the last updated record's timestamp, it generates the cache keys for all the the AR records and minifies the cache key generated when you use an AR Relation in the cache helper.

### Installation

Add the gem to your gemfile

```ruby
# Gemfile
gem 'cach_em_all', :git => 'git://github.com/obranchr/cach_em_all.git'
```

Then run `bundle install`. And you're ready to go.

### Usage (why and how)

Let's suppose that your website's footer shows your partners and the acceptable payment types for it's service. Every page loaded demands to load the footer, which will require to load all your payment types and partners. You could use a fragment cache in order to cache your footer, since it will only change when a partner or payment type change. According to [caching_with_rails](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching) a way to achieve this, without have to worry about fragment expiring, would be to do something like this:
```ruby
module ApplicationHelper
  def cache_key_for_partners
    count          = Partner.count
    max_updated_at = Partner.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "partners/all-#{count}-#{max_updated_at}"
  end
  def cache_key_for_payment_types
    count          = PaymentType.count
    max_updated_at = PaymentType.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "payment_types/all-#{count}-#{max_updated_at}"
  end
end
```
Those helpers will generate cache_keys which will persist the same until there is an update in any record, an insertion or a deletion. With those helpers, it's easy to cache the footer (suppose that the footer is a partial called footer):
```ruby
<% cache [cache_key_for_partners, cache_key_for_payment_types] do %>
  <%= render "footer" %>
<% end %>
```

Another advantage of this method is the practicity to make Russian Doll Caching:
```ruby
<% cache(cache_key_for_partners) do %>
  <% Partner.all.each do |partner| %>
    <% cache(partner) do %>
      <%= link_to partner.name, partner_url(partner) %>
    <% end %>
  <% end %>
<% end %>
```

Using this gem you don't need to write those helpers, all you got to do is pass the name of the ActiveRecord to the cache helper. Our footer example will look like this:
```ruby
<% cache [Partner, PaymentType] do %>
  <%= render "footer" %>
<% end %>
```

About using `ActiveRecord::Relations`, if you pass a Relation to the cache helper, it will convert it to an array, therefore executing the query, and then it will concatenate the individual cache_key of each record, creating something like this to a result with seven elements:
`products/1-20130717201743/products-2-20130713134532/products-3-20130718211340/products-4-20130719012141/products-5-20130719012201/products-6-20130719012214/products-7-20130719012226`
This gem digests the Relation SQL and make ActiveRecord::Relations repond to cache_key with something like this:
`products/3a0f5b12c290eba6ccc1d30dcaaebf465159d2ae1f76ad01562c245f46204fa0-7-20130719012226`

### Examples

Russian Doll Caching with an AR called `Product`:
```ruby
<% cache(Product) do %>
  <% Product.all.each do |products| %>
    <% cache(product) do %>
      <%= link_to product.name, partner_url(product) %>
    <% end %>
  <% end %>
<% end %>
```

Caching a footer's partial which only change when there is a change in the records of `Partner` or `PaymentMethod`:
```ruby
<% cache [Partner, PaymentType] do %>
  <%= render "footer" %>
<% end %>
```

Caching a subset of featured products which are showed by `ProductCategory` and are changed only with the change in the `Product`'s records. In the following example, the result SQL of the ActiveRecord::Relation is used to generate the cache_key. Note that the relation Product.where(:product_category_id => @product_category.id, :active => true, :featured => true) is passed to the cache helper:
```ruby
# Product Class
class Product < ActiveRecord::Base
  belongs_to :product_category
  scope :active,    -> { where(active: true) }
  scope :featured,  -> { where(featured: true) }
end

# ProductCategory Class
class ProductCategory < ActiveRecord::Base
  has_many :products, touch: true
end

# View
# http://myawesomeecommerce/product-category/featured
<% cache @product_category.products.active.featured do %>
  # The products
<% end %>
```

### Development

#### Roadmap

- [ ] AR Calculations results cache
- [ ] Make scaffold generators have an option to generate cached scaffolds
- [ ] Make a config file and it's generator to select what cache features should be included by default and what should be optional

#### Changes

To see what has changed in recent versions of CacheEmAll, see the [CHANGELOG](http://github.com/obranchr/cach_em_all/blob/master/CHANGELOG.md).

#### Contributing

To see how to contribute to this gem, please read [CONTRIBUTING](http://github.com/obranchr/cach_em_all/blob/master/CONTRIBUTING.md).

### Copyright

Copyright © 2013 Oscar Esgalha. See [MIT-LICENSE](http://github.com/obranchr/cach_em_all/blob/master/MIT-LICENSE) for details.
