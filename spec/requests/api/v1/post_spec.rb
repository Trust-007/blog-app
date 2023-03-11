require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get api_v1_posts_path
      expect(response).to have_http_status(:success)
    end
  end
end
