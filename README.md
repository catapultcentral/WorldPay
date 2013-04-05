WorldPay iadmin Class
=====================

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

    gem 'WorldPay-iadmin', git: "git://github.com/catapultcentral/WorldPay-iadmin.git"

And then execute:

    $ bundle

Usage
-----

	require 'worldpay_iadmin'

	# Create a new WorldpayIadmin instance
	@installation_id = "12345"
	@password = "mypass"
	@iadmin = WorldpayIadmin.new(@installation_id, @password)
	
	@futurepay_id = "98765"
	
	# Cancel a FuturePay agreement
	if @iadmin.cancel_agreement(@futurepay_id)
	  puts "Agreement Cancelled"
	else
	  puts "Agreement Cancellation Failed\n"
	  puts @iadmin.response
	end
	
	# Modify a start date
	if @iadmin.modify_start_date(@futurepay_id, Time.now)
	  puts "Start Date Changed"
	else
	  puts "Start Date Change Failed\n"
	  puts @iadmin.response
	end
	
	# Debit an agreement
	if @iadmin.debit(@futurepay_id, 9.99)
	  puts "Debit Successful"
	else
	  puts "Debit Failed\n"
	  puts @iadmin.response
	end
	
	# Change an amount
	if @iadmin.change_amount(@futurepay_id, 9.99)
	  puts "Change Amount Successful"
	else
      puts "DChange Amount Failed\n"
      puts @iadmin.response
    end

Test Mode
---------

    @test_mode = true
    @iadmin = WorldpayIadmin.new(@installation_id, @password, @test_mode)
  
    # or
  
    @iadmin = WorldpayIadmin.new(@installation_id, @password)
    @iadmin.test_mode = true



