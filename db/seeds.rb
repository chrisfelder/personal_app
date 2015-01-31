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

gamestore = Gamestore.create(name: "Save1", turn: 0, char1: 1, user_id: 1)
gamestore = Gamestore.create(name: "Save2", turn: 0, char1: 2, user_id: 1)

challenge = Challenge.create(
  title: "Multiples of 3 and 5",
  description:  "           
    <p>
      If we list all the natural numbers below 10 that are multiples of
      3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
    </p>
    <p>Find the sum of all the multiples of 3 or 5 below 1000.</p>",
  code: "~~~ruby
    puts 'I like taco'
    ~~~"
)
