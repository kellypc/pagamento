require 'rails_helper'

describe 'Order create via API POST' do
  context 'create' do
    it 'successfully' do
      payment_method = create(:payment_method, :debit)
      client = create(:client)
      client_profile = create(:client_profile, client: client)

      expect do
        post "/api/v1/client/#{client_profile.auth_token}/order?"\
             'order_value=500&order_id=24&payment_method_id=1'

      end.to change(Order, :count).by(1)

      expect(response).to have_http_status(:created)
      order = Order.last
      expect(order.order_id).to eq(24)
      expect(order.client_token).to eq(client_profile.auth_token)
    end
  end
end
