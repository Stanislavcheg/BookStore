require 'rails_helper'

RSpec.describe BillingAddressesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attrs) { FactoryGirl.attributes_for(:billing_address) }
  let(:invalid_attrs) { FactoryGirl.attributes_for(:billing_address, first_name: '') }
  let(:user_with_address) { FactoryGirl.create(:user_with_address) }

  describe 'POST create' do
    before do
      sign_in user
    end

    context 'valid' do
      it 'redirects to user settings route' do
        post :create, params: { billing_address: valid_attrs }
        expect(response).to redirect_to(edit_user_registration_url)
      end
      it 'creates new user billing address in database' do
        expect {
          post :create, params: { billing_address: valid_attrs }
        }.to change(BillingAddress, :count).by(1)
      end
    end
    context 'invalid' do
      it 'renders user settings template' do
        post :create, params: { billing_address: invalid_attrs }
        expect(response).to render_template('devise/registrations/edit')
      end
      it "doesn't create new user billing address in database" do
        expect {
          post :create, params: { billing_address: invalid_attrs }
        }.not_to change(BillingAddress, :count)
      end
    end
  end

  describe 'PUT update' do
    before do
      sign_in user_with_address
    end

    let(:logged_user) { subject.current_user }

    context 'valid' do
      it 'redirects to user settings route' do
        put :update, params: { id: logged_user.billing_address.id, billing_address: valid_attrs }
        expect(response).to redirect_to(edit_user_registration_url)
      end
      it 'updates user billing address in database' do
        put :update, params: { id: logged_user.billing_address.id, billing_address: valid_attrs }
        expect(logged_user.billing_address.first_name).to eq(valid_attrs[:first_name])
      end
    end
    context 'invalid' do
      it 'renders user settings route' do
        put :update, params: { id: logged_user.billing_address.id, billing_address: invalid_attrs }
        expect(response).to render_template('devise/registrations/edit')
      end
      it "doesn't update user billing address in database" do
        put :update, params: { id: logged_user.billing_address.id, billing_address: invalid_attrs }
        expect(logged_user.billing_address.first_name).not_to eq(invalid_attrs[:first_name])
      end
    end
  end
end
