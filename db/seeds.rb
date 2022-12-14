User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true)

# User.create!(name: "Manager User", email: "manager@railstutorial.org", password: "manager", password_confirmation: "manager", manager: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end


# Posts
users = User.order(:created_at).take(6)
50.times do
  date = "05/07/2017"
  distance = "20"
  time = "4:28"
  users.each { |user| user.posts.create!(date: date, distance: distance, time: time) }
end