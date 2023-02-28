require 'rails_helper'

RSpec.describe 'Users Controller', type: :request do
  context 'GET #index for users' do
    before(:example) { get users_path }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes placeholder text' do
      expect(response.body).to include('Here is a list of users')
    end
  end
  context 'Get #show for user' do
    before(:example) { get user_path(id: 1) }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('show')
    end
    it 'includes placeholder text' do
      expect(response.body).to include('Here is a single user')
    end
  end
end
