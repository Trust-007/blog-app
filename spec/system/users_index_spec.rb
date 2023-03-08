require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'
RSpec.feature 'Static content', type: :feature do
  users = User.all
  before(:each) do 
    visit "#{base_url}/users"
  end
  scenario 'all users from the database are present' do
    users.each { |user| expect(page).to have_content user.name }
  end

  scenario 'each user has the right number of posts' do
    count = 3
    page.all('li').each.with_index(1) do |user|
      expect(user.all('p')[0].text.scan(/\d+/).first.to_i).to have_content users.find(count).posts_counter
      count = count - 1
    end
  end

  scenario 'each user has his/her image displayed' do
    expect(page.all('img')[0]['src']).to eq users.find(2).photo
    expect(page.all('img')[1]['src']).to eq users.find(3).photo
    expect(page.all('img')[2]['src']).to eq users.find(1).photo
  end

  scenario 'each username links to the /users/:id page (show action)' do
    User.all.each.with_index do |_user, index|
      username = page.all('li')[index]

      expected_url = "#{base_url}/users/#{User.find_by(name: username.find('h3').text).id}"

      username.find('a').click

      expect(page).to have_current_path(expected_url)

      visit "#{base_url}/users"
    end
  end
end