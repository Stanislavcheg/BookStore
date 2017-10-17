require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attrs) { { email: 'example@mail.com' } }
  let(:invalid_attrs) { { email: '' } }

  describe 'PUT update_email' do
    before do
      sign_in user
    end

    let(:logged_user) { subject.current_user }

    context 'valid' do
      it 'redirects to user settings route' do
        put :update_email, params: { id: logged_user.id, user: valid_attrs }
        expect(response).to redirect_to(edit_user_registration_url)
      end
      it 'updates user email in database' do
        put :update_email, params: { id: logged_user.id, user: valid_attrs }
        logged_user.reload
        expect(logged_user.email).to eq(valid_attrs[:email])
      end
    end
    context 'invalid' do
      it 'renders user settings template' do
        put :update_email, params: { id: logged_user.id, user: invalid_attrs }
        expect(response).to render_template('devise/registrations/edit')
      end
      it "doesn't update user email in database" do
        put :update_email, params: { id: logged_user.id, user: invalid_attrs }
        logged_user.reload
        expect(logged_user.email).not_to eq(invalid_attrs[:email])
      end
    end
  end
end
