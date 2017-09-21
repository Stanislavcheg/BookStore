require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  describe 'unauthorized user' do
    it 'redirects to login page' do
      get :show, params: { id: "address" }
      expect(response).to redirect_to(new_user_session_url)
    end
  end
  describe 'logged user' do
    let(:user) { FactoryGirl.create(:user_with_orders) }

    before do
      sign_in user
      session[:order_id] = subject.current_user.orders.first.id
      session[:prev_step_done] = true
    end

    let(:order) { Order.find(session[:order_id]) }

    describe 'GET show' do
      describe 'address step' do
        it 'renders :address template' do
          get :show, params: { id: 'address' }
          expect(response).to render_template(:address)
        end
        context"when user's addresses exist" do
          before do
            subject.current_user.billing_address = FactoryGirl.create(:billing_address)
            subject.current_user.shipping_address = FactoryGirl.create(:shipping_address)
          end
          context "when order's addresses exist" do
            it "assigns order's addresses to @addresses_form" do
              order.billing_address = FactoryGirl.create(:billing_address)
              order.shipping_address = FactoryGirl.create(:shipping_address)
              get :show, params: { id: 'address' }
              expect(assigns(:addresses_form).billing_address.id).to eq(order.billing_address.id)
              expect(assigns(:addresses_form).shipping_address.id).to eq(order.shipping_address.id)
            end
          end
          context "when order's addresses don't exist" do
            it "assigns user's addresses to @addresses_form" do
              get :show, params: { id: 'address' }
              expect(assigns(:addresses_form).billing_address.id).to eq(subject.current_user.billing_address.id)
              expect(assigns(:addresses_form).shipping_address.id).to eq(subject.current_user.shipping_address.id)
            end
          end
        end
      end
      describe 'delivery step' do
        it 'renders :delivery template' do
          get :show, params: { id: 'delivery' }
          expect(response).to render_template(:delivery)
        end
      end
      describe 'payment step' do
        it 'renders :payment template' do
          get :show, params: { id: 'payment' }
          expect(response).to render_template(:payment)
        end
        context "when order's credit card exists" do
          it "assigns order's credit card to @payment_form" do
            order.credit_card = FactoryGirl.create(:credit_card)
            get :show, params: { id: 'payment' }
            expect(assigns(:payment_form).number).to eq(order.credit_card.number.to_s)
          end
        end
      end
      describe 'confirm step' do
        it 'renders :confirm template' do
          get :show, params: { id: 'confirm' }
          expect(response).to render_template(:confirm)
        end
      end
      describe 'complete step' do
        it 'renders :complete template' do
          get :show, params: { id: 'complete' }
          expect(response).to render_template(:complete)
        end
      end
    end
    describe 'PUT update' do
      describe 'address step' do
        let(:billing_valid_attrs) { FactoryGirl.attributes_for(:billing_address) }
        let(:billing_invalid_attrs) { FactoryGirl.attributes_for(:billing_address, first_name: '') }
        let(:shipping_valid_attrs) { FactoryGirl.attributes_for(:shipping_address) }
        let(:shipping_invalid_attrs) { FactoryGirl.attributes_for(:shipping_address, first_name: '') }

        context 'valid' do
          it 'redirects to delivery step' do
            put :update, params: { id: "address", billing_address: billing_valid_attrs, shipping_address: shipping_valid_attrs }
            expect(response).to redirect_to(checkout_url :delivery)
          end
          context "when order's addresses exist" do
            it "updates order's billing and shipping addresses in database" do
              order.billing_address = FactoryGirl.create(:billing_address)
              order.shipping_address = FactoryGirl.create(:shipping_address)
              put :update, params: { id: "address", billing_address: billing_valid_attrs, shipping_address: shipping_valid_attrs }
              order.reload
              expect(order.billing_address.first_name).to eq(billing_valid_attrs[:first_name])
              expect(order.shipping_address.first_name).to eq(shipping_valid_attrs[:first_name])
            end
          end
          context "when order's addresses don't exist" do
            it "creates new order's billing address in database" do
              expect {  put :update, params: { id: "address", billing_address: billing_valid_attrs, shipping_address: shipping_valid_attrs } }.to change(BillingAddress, :count).by(1)
            end
            it "creates new order's shipping address in database" do
              expect {  put :update, params: { id: "address", billing_address: billing_valid_attrs, shipping_address: shipping_valid_attrs } }.to change(ShippingAddress, :count).by(1)
            end
          end
        end
        context 'invalid' do
          it 'renders address step' do
            put :update, params: { id: "address", billing_address: billing_invalid_attrs, shipping_address: shipping_valid_attrs }
            expect(response).to render_template('checkout/address')
          end
          context "when order's addresses exist" do
            it "doesn't update order's addresses in database" do
              order.billing_address = FactoryGirl.create(:billing_address)
              order.shipping_address = FactoryGirl.create(:shipping_address)
              put :update, params: { id: "address", billing_address: billing_invalid_attrs, shipping_address: shipping_invalid_attrs }
              order.reload
              expect(order.billing_address.first_name).not_to eq(billing_invalid_attrs[:first_name])
              expect(order.shipping_address.first_name).not_to eq(shipping_invalid_attrs[:first_name])
            end
          end
          context "when order's addresses don't exist" do
            it "doesn't create new order's billing address in database" do
              expect {  put :update, params: { id: "address", billing_address: billing_invalid_attrs, shipping_address: shipping_invalid_attrs } }.not_to change(BillingAddress, :count)
            end
            it "doesn't create new order's shipping address in database" do
              expect {  put :update, params: { id: "address", billing_address: billing_invalid_attrs, shipping_address: shipping_invalid_attrs } }.not_to change(ShippingAddress, :count)
            end
          end
        end
      end
      describe 'delivery step' do
        let(:delivery) { FactoryGirl.create(:delivery) }

        it 'redirects to payment step' do
          put :update, params: { id: "delivery", delivery: { id: delivery.id } }
          expect(response).to redirect_to(checkout_url :payment)
        end
        context "when order's delivery exists" do
          it "updates order's delivery in database" do
            order.delivery = FactoryGirl.create(:delivery)
            put :update, params: { id: "delivery", delivery: { id: delivery.id } }
            order.reload
            expect(order.delivery.id).to eq(delivery.id)
          end
        end
        context "when order's delivery doesn't exist" do
          it "links delivery to the order" do
            put :update, params: { id: "delivery", delivery: { id: delivery.id } }
            expect(order.delivery).not_to be_nil
          end
        end
      end
      describe 'payment step' do
        let(:credit_card) { FactoryGirl.create(:credit_card) }
        let(:valid_attrs) { FactoryGirl.attributes_for(:credit_card) }
        let(:invalid_attrs) { FactoryGirl.attributes_for(:credit_card, number: "fff") }

        describe 'valid' do
          it 'redirects to confirm step' do
            put :update, params: { id: 'payment', credit_card: valid_attrs }
            expect(response).to redirect_to(checkout_url :confirm)
          end
          context "when order's credit card exists" do
            it "updates order's credit card in database" do
              order.credit_card = FactoryGirl.create(:credit_card)
              put :update, params: { id: 'payment', credit_card: valid_attrs }
              order.reload
              expect(order.credit_card.number.to_s).to eq(valid_attrs[:number])
            end
          end
          context "when order's credit card doesn't exist" do
            it "creates new order's credit card in database" do
              expect {  put :update, params: { id: 'payment', credit_card: valid_attrs } }.to change(CreditCard, :count).by(1)
            end
          end
        end
        describe 'invalid' do
          it 'renders payment step' do
            put :update, params: { id: "payment", credit_card: invalid_attrs }
            expect(response).to render_template('checkout/payment')
          end
          context "when order's credit card exists" do
            it "doesn't update order's credit card in database" do
              order.credit_card = FactoryGirl.create(:credit_card)
              put :update, params: { id: 'payment', credit_card: invalid_attrs }
              order.reload
              expect(order.credit_card.number.to_s).not_to eq(invalid_attrs[:number])
            end
          end
          context "when order's credit card doesn't exist" do
            it "doesn't create new order's credit card in database" do
              expect {  put :update, params: { id: 'payment', credit_card: invalid_attrs } }.not_to change(CreditCard, :count)
            end
          end
        end
      end
    end
  end
end
