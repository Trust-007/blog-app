require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

posts_id = User.find(1).posts.map(&:id)
random_post = posts_id[rand(0...posts_id.length)]

RSpec.feature 'Posts#show view', type: :feature do
  before(:each) do
    @user = User.find(1)
    visit "#{base_url}/users/1/posts/#{random_post}"
  end

  scenario 'post title is visible on the page' do
    expect(page).to have_selector('.post_card_main div h3')
  end

  scenario 'post author is visible on the page' do
    author = page.find('.post_card_main div h3').text.split(/ by /)[1]

    expect(author).to eq @user.name
  end

  scenario 'the number of comments of the post is shown on the page' do
    number_of_comments = page.find('.comments_likes').text

    expect(number_of_comments).to have_content Post.find(random_post).comments_counter.to_s
  end

  scenario 'the number of likes of the post is shown on the page' do
    number_of_likes = page.find('.comments_likes').text

    expect(number_of_likes).to have_content Post.find(random_post).likes_counter.to_s
  end
end

RSpec.feature 'Posts#show view', type: :feature do
  before(:each) do
    @user = User.find(1)
    visit "#{base_url}/users/1/posts/#{random_post}"
  end

  scenario 'the post body is displayed on the page' do
    expect(Post.find(random_post).text).to eq page.find('div p').text
  end

  scenario 'the name of each commentor appears on the page' do
    if @user.id == 1
      page_commentors = page.all('.comments2 li').map { |c| c.text.split(/ : /)[0] }
      post_commentors = Post.includes(comments: :author).find(random_post).comments.map { |c| c.author.name }

      expect(page_commentors).to eq post_commentors
    end
  end

  scenario 'all the comments are displayed on the page' do
    if @user.id == 1
      page_comments = page.all('.comments2 li').map { |c| c.text.split(/ : /)[1] }
      post_comments = Post.includes(comments: :author).find(random_post).comments.map(&:text)

      expect(page_comments).to eq post_comments
    end
  end
end

RSpec.feature 'Posts#show view', type: :feature do
  before(:each) do
    @user = User.find(1)
    visit "#{base_url}/users/1/posts/#{random_post}"
  end
end
