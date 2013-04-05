require_relative '../lib/worldpay'
gem 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'fakeweb'

MiniTest::Reporters.use! [MiniTest::Reporters::ProgressReporter.new]

module WorldPay
  $test_mode = true
end

def create_worldpay_iadmin(response)
  worldpay_iadmin = WorldPay::Iadmin.new('123434', 'password', true)
  FakeWeb.register_uri(:any, worldpay_iadmin.url + "/wcc/iadmin", body: response)
  worldpay_iadmin
end