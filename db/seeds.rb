# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(name: "James Kirk", email: "james@kirk.com",
                    password: "password", password_confirmation: "password")

character = Character.create(name: "Paul McCartney" ,  strength: 10,
  defense: 10, hp_current: 100, hp_max: 100, user_id: 1, miner: 0, lumberjack: 0, 
    hunter: 0, builder: 0, farmer: 0)
    
character = Character.create(name: "John Lennon" ,  strength: 12,
  defense: 10, hp_current: 100, hp_max: 100, user_id: 1, miner: 0, lumberjack: 0, 
    hunter: 0, builder: 0, farmer: 0)
    
character = Character.create(name: "George Harrison" ,  strength: 10,
  defense: 11, hp_current: 100, hp_max: 100, user_id: 1, miner: 0, lumberjack: 0, 
    hunter: 0, builder: 0, farmer: 0)
    
character = Character.create(name: "Ringo Starr" ,  strength: 10,
  defense: 12, hp_current: 100, hp_max: 100, user_id: 1, miner: 0, lumberjack: 0, 
    hunter: 0, builder: 0, farmer: 0)

