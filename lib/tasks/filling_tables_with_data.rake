# encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    make_users
    make_enterprises
#    make_relationships
  end
end

def make_users
  User.delete_all
  admin = User.create(username: "Example User", 
                      email: "example@railstutorial.org", 
                      password: "foobar", 
                      remember_me: false)
  admin.toggle!(:admin)
  5.times do |n|
    username = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(username: username, 
                 email: email, 
                 password: password, 
                 password_confirmation: password, 
                 remember_me: false)
  end
end

def make_enterprises
  Enterprise.delete_all
  
  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 1', 
                                      uch_nomer_plat: '123456789', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(1)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 2', 
                                      uch_nomer_plat: '987654321', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 2 для юзера 2', 
                                      uch_nomer_plat: '123456789', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise
  
  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 3', 
                                      uch_nomer_plat: '987654321', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(3)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 4', 
                                      uch_nomer_plat: '123456789', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(4)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 5', 
                                      uch_nomer_plat: '987654321', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(5)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Рога унд Копыта 1 для юзера 6', 
                                      uch_nomer_plat: '123456789', 
                                      edinic_izmer: 'млн. рубл.')
  user = User.find_by_id(6)
  user.enterprises << new_enterprise
end

#
#def make_relationships
#  users = User.all
#  user = users.first
#  followed_users = users[2..50]
#  followers = users[3..40]
#  followed_users.each { |followed| user.follow!(followed) }
#  followers.each { |follower| follower.follow!(user) }
#end