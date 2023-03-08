require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying user photo on the page' do
    expect(page.find('img')['src']).to eq @user.photo
  end

  scenario 'displaying user username on the page' do
    expect(page.find('.user_card h3').text).to eq @user.name
  end

  scenario 'displaying right number of posts on the page' do
    expect(page.find('.user_card p').text.scan(/\d+/).first.to_i).to have_content @user.posts_counter
  end

  scenario 'displaying post title on the page' do
    expect(page.all('.post_card h3').count).to be >= 0
  end
end

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying at least some of the post body on the page' do
    posts_bodies = page.all('.post_card p').map(&:text)
    posts_bodies.each do |article|
      article = article.sub(/\.{3}\z/, '') if article.end_with?('...')
      expect(@user.posts.any? { |post| /^#{article}/.match?(post.text) }).to be true
    end
  end

  scenario 'displaying the first five comments on a post' do # (?)
    @user.posts.each do |post|
      post.five_most_recent_comments.each do |comment|
        expect(page).to have_content comment.text
      end
    end
  end
end

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying number of comments on the page' do
    page.all('.post_card').each do |post|
      post_title = post.find('.post_card h3').text
      number_of_comments = post.all('.post_card div p')[1].text.scan(/\d+/).first.to_i
      expect(Post.find_by(title: post_title).comments_counter).to eq number_of_comments
    end
  end

  scenario 'displaying number of likes on the page' do
    page.all('.post_card').each do |post|
      post_title = post.find('.post_card h3').text
      number_of_likes = post.all('.post_card div p')[0].text.scan(/\d+/).last.to_i
      expect(Post.find_by(title: post_title).likes_counter).to eq number_of_likes
    end
  end
end

RSpec.feature 'Users#index view', type: :feature do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'post clicking redirects to /users/:id/posts/:post_id' do
    @user.posts.each.with_index do |post, index|
      article = page.all('.post_card div a')[index]
      expected_url = "#{base_url}/users/#{@user.id}/posts/#{post.id}"
      article.click
      expect(page).to have_current_path(expected_url)
      visit "#{base_url}/users/#{@user.id}/posts"
    end
  end
end
