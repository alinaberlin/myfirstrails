#generate a payment controler 
#create method (and a corresponding POST route). This is where the form will submit data to.
class PaymentController < ApplicationController
  def create
    prid = params[:product_id]
    @product = Product.find(prid)
    @user = current_user
    token = params[:stripeToken]
    @redirect_path = product_path(@product)
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: @product.price*100, # amount in cents, again
        currency: "eur",
        source: token,
        description: params[:stripeEmail],
        receipt_email: @user.email
      )
      #create a new order if payment is succesfull(6.6)
      if charge.paid
        @order = Order.create!(user: @user, product: @product, total: @product.price)
        flash[:notice] = "Your payment has been processed successfully"
        @redirect_path = order_path(@order)
      end
      #catching the Stripe::CardError error and handling it 
    rescue Stripe::CardError => e
      # The card has been declined
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      # The following fields are optional
      puts "Code is: #{err[:code]}" if err[:code]
      puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
      puts "Param is: #{err[:param]}" if err[:param]
      puts "Message is: #{err[:message]}" if err[:message]
      flash[:error] = "Your payment has been rejected"
    end
    redirect_to @redirect_path
  end
  
end
