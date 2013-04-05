require_relative "spec_helper"

describe WorldPay::PaymentForm do
	let(:required_args) { { instId: "123456", cartId: "42733724", amount: "42.73", currency: "GBP" } }

	it "must explode when a require argument is not passed" do
		required_args.keys.each do |key|
			required_args.delete(key)
			lambda { WorldPay::PaymentForm.new(required_args) }.must_raise ArgumentError
		end
	end

	it "must set the payment_form form action based on the test mode" do
		payment_form1 = WorldPay::PaymentForm.new(required_args)

		payment_form1.action.must_equal "https://secure.worldpay.com/wcc/purchase"

		payment_form2 = WorldPay::PaymentForm.new(required_args.merge(testMode: true))

		payment_form2.action.must_equal "https://secure-test.worldpay.com/wcc/purchase"
	end

	describe "generate()" do
		it "must respond to generate" do
			payment_form = WorldPay::PaymentForm.new(required_args)

			payment_form.must_respond_to :generate
		end

		it "must return a string" do
			payment_form = WorldPay::PaymentForm.new(required_args.merge(testMode: true))

			payment_form.generate.must_be_instance_of String
		end
	end
end