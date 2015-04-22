class CostumersController < ApplicationController
load_and_authorize_resource

def show
  unless current_costumer.billing_adress.nil?
    @billing_adress = current_costumer.billing_adress
  else
    @billing_adress = BillingAdress.new
  end
  unless current_costumer.adress.nil?
    @adress = current_costumer.adress
  else
    @adress = Adress.new
  end
  unless current_costumer.credit_card.nil?
    @credit_card = current_costumer.credit_card
  else
    @credit_card = CreditCard.new
  end
   if @billing_adress.shipping?
    if current_costumer.adress.nil?
        @adress = Adress.new(costumer_id: current_costumer.id)
      end
      @adress.adress = @billing_adress.adress
      @adress.zipcode = @billing_adress.zipcode
      @adress.city = @billing_adress.city
      @adress.phone = @billing_adress.phone
      @adress.country_id = @billing_adress.country_id
      @adress.save
    end
end

  def update

    respond_to do |format|
      if @costumer.update(costumer_params)
        format.html { redirect_to @costumer, notice: 'Costumer was successfully updated.' }
        format.json { render :show, status: :ok, location: @costumer }
      else
        format.html { render :edit }
        format.json { render json: @costumer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def costumer_params
      params.require(:costumer).permit(:firstname, :lastname)
    end
end
