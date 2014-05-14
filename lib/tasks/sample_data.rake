namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    User.create!(name: "Jarek",
                 email: "konie@koniowo.com",
                 password: "koniowo",
                 password_confirmation: "koniowo",
                 admin: true)
    50.times do |n|
      name  = Faker::Name.name.slice(0,12)
      email = "example-#{n+1}@bdimension.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      snippet = Faker::Lorem.sentence(5)
      users.each { |user| user.gists.create!(snippet: snippet) }
    end
  end
end
