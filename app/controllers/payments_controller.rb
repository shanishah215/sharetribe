class PaymentsController < ApplicationController
	before_filter do |controller|
    controller.ensure_logged_in t("layouts.notifications.you_must_log_in_to_view_your_settings")
  end

  # before_filter :ensure_paypal_enabled


  def checkout
  	gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(
		  :login => "testaccountno1_api1.gmail.com",
		  :password => "68ZJVZX9L9L2RNDH",
		  :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AMGFwgyTIS1Gm8JVkqqBEoCcVpzs",
		  :appid => "APP-80W284485P519543T" )

  	puts 'gateway '*100
  	puts gateway.inspect
  	
		recipients = [{:email => 'quinn-facilitator@gmail.com',
	               :amount => 8,
	               :primary => true},
	              {:email => 'quinnamcnamara-facilitator@gmail.com ',
	               :amount => 2,
	               :primary => false}
	               ]
		response = gateway.setup_purchase(
		  :return_url => url_for(:action => 'return_of_paypal', :only_path => false),
		  :cancel_url => url_for(:action => 'return_of_paypal', :only_path => false),
		  :ipn_notification_url => url_for(:action => 'return_of_paypal', :only_path => false),
		  :receiver_list => recipients
		)

		puts 'paypal response '*100
		puts response.inspect
		puts

		# For redirecting the customer to the actual paypal site to finish the payment.
		redirect_to (gateway.redirect_url_for(response["payKey"]))
  end

  def return_of_paypal
  end

  private
  def init_paypal_gateway
  	gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(
		  :login => "quinnamcnamara_api1.gmail.com",
		  :password => "QYJQDSXAW7UNNX3J",
		  :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31A.dl7Tp0zHXzakPUf6gqwqzBmyp0",
		  :appid => "APP-80W284485P519543T" )
  	gateway
  end
end
