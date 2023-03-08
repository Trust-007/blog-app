# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(name: 'James', photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcK9z9GNP3LFVSk4kpiJZI41gbchoTVLcyXmMsgYg&s', bio: 'Teacher from Mexico.', posts_counter: 0)
second_user = User.create(name: 'Hatim', photo: 'https://img.freepik.com/free-vector/cute-astronaut-dance-cartoon-vector-icon-illustration-technology-science-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3851.jpg?w=2000', bio: 'Teacher from Poland.', posts_counter: 0)
third_user = User.create(name: 'Trust', photo: 'https://img.freepik.com/free-vector/cute-monster-kid-cartoon-vector-icon-illustration-monster-holiday-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3995.jpg?w=2000', bio: 'Teacher from USA.',posts_counter: 0)

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0, author_id: first_user.id)
second_post = Post.create(author: first_user, title: 'Software', text: 'This is my second post', likes_counter: 0, comments_counter: 0, author_id: first_user.id)
third_post = Post.create(author: first_user, title: 'Hello', text: 'This is my third post', likes_counter: 0, comments_counter: 0, author_id: first_user.id)
fourth_post = Post.create(author: first_user, title: 'Hello', text: 'This is my fourth post', likes_counter: 0, comments_counter: 0, author_id: first_user.id)
fifth_post = Post.create(author: first_user, title: 'Hello', text: 'This is my fifth post', likes_counter: 0, comments_counter: 0, author_id: first_user.id)

Comment.create(post: first_post, author: first_user, text: 'Hi Tom!', post_id: first_post.id, author_id: first_user.id)
Comment.create(post: first_post, author: first_user, text: 'Great work!', post_id: first_post.id, author_id: first_user.id )
Comment.create(post: first_post, author: first_user, text: 'I like the code!', post_id: first_post.id, author_id: first_user.id )
Comment.create(post: first_post, author: first_user, text: 'Good review!', post_id: first_post.id, author_id: first_user.id )
Comment.create(post: first_post, author: first_user, text: 'Wonderful news!', post_id: first_post.id, author_id: first_user.id )
Comment.create(post: first_post, author: first_user, text: 'Well Done!', post_id: first_post.id, author_id: first_user.id )
Comment.create(post: first_post, author: first_user, text: 'Awesome!', post_id: first_post.id, author_id: first_user.id )