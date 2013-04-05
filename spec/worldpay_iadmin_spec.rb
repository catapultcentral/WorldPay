require_relative "spec_helper"

describe WorldPay::Iadmin do
  it "must initialize the WorldPay::Iadmin instance correctly" do
    worldpay_iadmin = WorldPay::Iadmin.new "123456", "password", true

    worldpay_iadmin.worldpay_id.must_equal "123456"
    worldpay_iadmin.instance_variable_get(:@password).must_equal "password"
    worldpay_iadmin.test_mode.must_equal true
  end

  it "must return true if an agreement was successfully cancelled" do
    assert create_worldpay_iadmin("Y, Start date set OK").cancel_agreement("232323")
  end

  it "must reutn false if an agreement failed to be cancelled" do
    refute create_worldpay_iadmin("E, Problem cancelling agreement").cancel_agreement("232323")
  end

  it "must return true if an agreement's start date was successfully set or changed" do
    assert create_worldpay_iadmin("Y, Start date set OK").modify_start_date("232323", Time.now)
  end

  it "must return false if an agreement's start date failed to be set or changed" do
    refute create_worldpay_iadmin("E, Agreement already has start date").modify_start_date("232323", Time.now)
  end

  it "must return true if an agreement's amount was changed successfully" do
    assert create_worldpay_iadmin("Y, Amount updated").change_amount("232323", 9.99)
  end

  it "must return false if an agreement's amount failed to be changed" do
    refute create_worldpay_iadmin("E, Amount is fixed").change_amount("232323", 9.99)
  end

  it "must return true if an account was successfully debitted" do
    assert create_worldpay_iadmin("Y, transId,A,rawAuthMessage,Payment successful").debit("232323", 9.99)
  end

  it "must return false if an account failed to be debitted" do
    refute create_worldpay_iadmin("E, Agreement already finished").debit("232323", 9.99)
  end

  it "must set the production url correctly" do
    iadmin = WorldPay::Iadmin.new "123434", "password"
    iadmin.url.must_equal "https://secure.wp3.rbsworldpay.com"
  end

  it "must set the test url correctly" do
    iadmin = WorldPay::Iadmin.new "123434", "password", true
    iadmin.url.must_equal "https://secure-test.worldpay.com"
  end
end