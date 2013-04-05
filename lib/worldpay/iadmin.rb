module WorldPay
  class Iadmin
    attr_reader :worldpay_id, :reponse, :url
    attr_accessor :test_mode
  
    def initialize(worldpay_id, password, test_mode = false)
      @worldpay_id = worldpay_id
      @password = password
      @test_mode = test_mode
      @url = test_mode ? 'https://secure-test.wp3.rbsworldpay.com' : 'https://secure.wp3.rbsworldpay.com'

      # Setup the faraday connection
      @conn = Faraday.new(:url => @url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger unless $test_mode  # Enable the logger except when running tests
        faraday.adapter  Faraday.default_adapter
      end
    end
  
    # Cancels an existing FuturePay agreement
    def cancel_agreement(futurepay_id)
      make_request futurePayId: futurepay_id, 'op-cancelFP' => ''
    end
  
    # Change or specify a FuturePay agreement's start date
    def modify_start_date(futurepay_id, start_date)
      make_request futurePayId: futurepay_id, startDate: start_date.strftime('%Y-%m-%d'), 'op-startDateRFP' => ''
    end
  
    # Change the amount/price of subsequent debits for option 1 or 2 agreements, providing that there is at least
    # 8 days before 00:00 GMT on the day the payment is due.
    def change_amount(futurepay_id, amount)
      make_request futurePayId: futurepay_id, amount: amount, 'op-adjustRFP' => ''
    end
  
    # Debit from an agreement
    def debit(futurepay_id, amount)
      make_request futurePayId: futurepay_id, amount: amount, 'op-paymentLFP' => ''
    end
  
    private
  
    # Returns <code>true</code> if the passed response string indicated the action was sucessful
    def check(response)
      response =~ /^Y,/
    end
  
    # Returns <code>true</code> if able to connect to WorldPay the action was carried out
    def make_request(command_params)
      params = { instId: @worldpay_id, authPW: @password }
      params.merge! command_params
      params.merge! testMode: '100' if @test_mode

      response = @conn.post '/wcc/iadmin', params
    
      case response.status
      when 200, 302
        @response = response.body.strip
        return check @response
      else
        @response = 'Connection Error'
        return false
      end
    end
  end
end