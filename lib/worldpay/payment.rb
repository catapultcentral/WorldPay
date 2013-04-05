module WorldPay
  class PaymentForm
  	attr_reader :action

  	def initialize(params)
  		[:instId, :cartId, :amount, :currency].each do |required_arg|
  			raise ArgumentError, "The #{required_arg} argument is required!" unless params.include? required_arg
  		end

  		@action = params[:testMode] ? "https://secure-test.worldpay.com/wcc/purchase" : "https://secure.worldpay.com/wcc/purchase"
  		@params = parse params
  	end

  	def generate
  		builder = Builder::XmlMarkup.new(indent: 4)
  		form = builder.form(action: @action, method: "POST") {
  			@params.keys.each do |key|
  				builder.input(type: "hidden", name: key.to_s, value: @params[key])
  			end

  			builder.input(type: "submit", value: "")
  		}

  		form
  	end

  	private

  	def parse(params)
  		if params[:testMode]
  			params[:testMode] = "100"
  		else
  			params.delete :testMode
  		end

  		params
  	end
  end
end