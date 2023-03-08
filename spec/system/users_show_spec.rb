require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her image displayed' do
    expect(page.find('img')['src']).to eq @user.photo
  end

  scenario 'username is displayed on the page' do
    expect(page.find('.user_card h3').text).to eq @user.name
  end

  scenario 'user has the right number of posts' do
    expect(page.find('.user_card p').text.scan(/\d+/).first.to_i).to have_content @user.posts_counter
  end

  scenario 'user has the right bio displayed' do
    expect(page.find('.bio_card p').text).to eq @user.bio
  end
end

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her first three (or less than) posts displayed' do
    page_posts = page.all('.post_card')
    page_posts = page_posts.map do |post|
      {
        title: post.find('h3').text,
        text: post.find('p').text
      }
    end

    @user.three_most_recent_post.each_with_index do |post, index|
      database_post = { title: post.title, text: post.text }
      expect(database_post).to eq page_posts[index]
    end
  end

  scenario "the page displays a button that lets me see all the user's posts" do
    button = page.find('button a')

    expect(button.text).to eq 'See all posts'
    expect(button['href']).to eq "/users/#{random_number}/posts"
  end
end

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'clicking on All Posts button redirects me to all posts page' do
    page.find('button a').click

    expect(page).to have_current_path("#{base_url}/users/#{random_number}/posts")
  end
end
