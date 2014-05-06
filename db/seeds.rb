require 'faker'

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    email: Faker::Internet.email,
    user_name: Faker::Name.name, 
    password: password, 
    password_confirmation: password)
  u.save

  rand(10..30).times do
    t = u.topics.create(title: Faker::Lorem.words(rand(1..4)).join("\n"))
    rand(3..10).times do
      u.posts.create(
        topic: t, 
        url: Faker::Internet.url)
    end
  end
end

u = User.new(
  email: 'melanie.keatley@gmail.com',
  user_name: 'Mel', 
  password: 'blocmarks1', 
  password_confirmation: 'blocmarks1')
u.save
u.update_attribute(:role, 'member')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"

