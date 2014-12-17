class Character < ActiveRecord::Base
    validates :name, presence: true
    validates :strength, presence: true
    validates :defense, presence: true
end
