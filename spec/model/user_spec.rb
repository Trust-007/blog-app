require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.', posts_counter: 0) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal or great than 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Subject should be valid' do
    expect(subject).to be_valid
  end


  context 'latest_post method' do
    before do
      4.times do
        Post.create(author: subject, title: 'James', text: 'This is my first post again', comments_counter: 0,
                    likes_counter: 0)
      end
    end

    it 'should retun the 3 latest posts' do
      expect(subject.three_most_recent_post.length).to eq 3
    end
  end
end
