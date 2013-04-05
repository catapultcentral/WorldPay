require_relative 'worldpay/version'
require_relative 'worldpay/iadmin'
require_relative 'worldpay/payment'
require 'faraday'
require 'builder'

module WorldPay
  $test_mode = false
end