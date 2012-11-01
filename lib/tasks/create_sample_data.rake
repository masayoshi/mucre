namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    make_users
    make_events
  end
end

def make_users
  50.times do |n|
    email = "foobar#{n}@foo.bar"
    password  = "password"
    @tmp_user = User.new(:username => Faker::Name.first_name + n.to_s,
                         :email => email,
                         :password => password,
                         :password_confirmation => password)
    @tmp_user.skip_confirmation!
    @tmp_user.save!
    @tmp_user.update_attributes!(:name => Faker::Name.name,
                                 :url => ("http://www." + Faker::Internet.domain_name),
                                 :biography => Faker::Lorem.sentence(10),
                                 :tag_list => Faker::Lorem.words(10).join(','))
  end
end

def make_events
  users = User.where(id: 1..5)
  users.each do |user|
    10.times do
      start_datetime = Time.at(rand * Time.now.to_i)
      end_datetime = start_datetime + 3.hours
      user.events.create(title: Faker::Lorem.sentence(5),
                         description: Faker::Lorem.sentence(10),
                         fee: rand(10000),
                         place: Faker::Lorem.sentence(3),
                         url: ("http://www." + Faker::Internet.domain_name),
                         tag_list: Faker::Lorem.words(5).join(','),
                         start_datetime: start_datetime,
                         end_datetime: end_datetime,
                         address: (Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state))
    end
  end
end
