WorldPay API wrapper
====================

WorldPay offer an api to do some remote administration tasks relating to FuturePay. The iadmin
api is not available by default. You must contact WorldPay and ask them to activate it for you. A
new installation id and password will be provided access the api. The api allows you to cancel a
FuturePay agreement, change the start date, debit an agreement, or modify the amount.

This class provides a simple lightweight interface to this api.

See the WorldPay docs for a list of error responses you can expect:

http://www.rbsworldpay.com/support/kb/bg/recurringpayments/rpfp8000.html

Requirements
------------

- Ruby 1.9+ with openssl
- Valid WorldPay account

### Gem dependencies

- faraday

### Gem development dependencies

- minitest
- minitest-reporters
- fakeweb

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'worldpay', git: "git://github.com/catapultcentral/WorldPay.git"
```

And then execute:

```sh
$ bundle
```

Usage
-----

```ruby
require 'worldpay'

# Create a new WorldpayIadmin instance
iadmin = WorldPay::Iadmin.new("123456", "password")

# Store the futurepay_id in a variable so that we can easily reuse it
futurepay_id = "98765"

# Cancel a FuturePay agreement
if iadmin.cancel_agreement(futurepay_id)
  puts "Agreement Cancelled"
else
  puts "Agreement Cancellation Failed\n"
  puts iadmin.response
end

# Modify a start date
if iadmin.modify_start_date(futurepay_id, Time.now)
  puts "Start Date Changed"
else
  puts "Start Date Change Failed\n"
  puts iadmin.response
end

# Debit an agreement
if iadmin.debit(futurepay_id, 9.99)
  puts "Debit Successful"
else
  puts "Debit Failed\n"
  puts iadmin.response
end

# Change an amount
if iadmin.change_amount(futurepay_id, 9.99)
  puts "Change Amount Successful"
else
  puts "DChange Amount Failed\n"
  puts iadmin.response
end
```

Test Mode
---------

```ruby
# Set the third parameter of the initilizer to true to enable Test Mode
iadmin = WorldpayIadmin.new("123456", "password", true)
```


