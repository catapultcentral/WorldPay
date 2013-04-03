require_relative 'worldpay-iadmin/version'
require 'net/http'
require 'net/https'
require 'uri'

class WorldpayIadmin
  attr_reader :reponse
  attr_accessor :worldpay_id, :test_mode, :production_url, :test_url
  
  def initialize(worldpay_id, password, test_mode = false)
    @worldpay_id = worldpay_id
    @password = password
    @test_mode = test_mode
    @production_url = 'https://secure.wp3.rbsworldpay.com/wcc/iadmin'
    @test_url = 'https://secure-test.wp3.rbsworldpay.com/wcc/iadmin'
  end
  
  # Returns the url that the command will be sent to
  def iadmin_url
    @test_mode ? @test_url : @production_url
  end
  
  # Cancels an existing FuturePay agreement
  def cancel_agreement(futurepay_id)
    run_command({:futurePayId => futurepay_id, 'op-cancelFP' => '' })
  end
  
  # Change or specify a FuturePay agreement's start date
  def modify_start_date(futurepay_id, start_date)
    run_command({:futurePayId => futurepay_id, :startDate => start_date.strftime('%Y-%m-%d'), 'op-startDateRFP' => '' })
  end
  
  # Change the amount/price of subsequent debits for option 1 or 2 agreements, providing that there is at least
  # 8 days before 00:00 GMT on the day the payment is due.
  def change_amount(futurepay_id, amount)
    run_command({:futurePayId => futurepay_id, :amount => amount, 'op-adjustRFP' => '' })
  end
  
  # Debit from an agreement
  def debit(futurepay_id, amount)
    run_command({:futurePayId => futurepay_id, :amount => amount, 'op-paymentLFP' => '' })
  end
  
  private
  
  # Returns <code>true</code> if the passed response string indicated the action was sucessful
  def check_response(response)
    response =~ /^Y,/ ? true : false
  end
  
  # Returns <code>true</code> if able to connect to WorldPay the action was carried out
  def run_command(command_params)
    params = {:instId => @worldpay_id, :authPW => @password}
    params.merge!(command_params)
    params.merge!({ :testMode => '100' }) if @test_mode
    
    url = URI.parse(iadmin_url)
    
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data(params)
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
                                  
    response = http.request(req)
    
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      @response = response.body.strip
      return check_response(@response)
    else
      @response = 'Connection Error'
      return false
    end
  end
end