class Character < ActiveRecord::Base
  belongs_to :user
  
    validates :user_id, presence: true
    validates :name, presence: true, length: {maximum: 50}
    validates :strength, presence: true, numericality: { greater_than: 0 }
    validates :defense, presence: true, numericality: { greater_than: 0 }
    validates :hp_max, presence: true, numericality: 
      { greater_than_or_equal_to: 0 }
    validates :hp_current, presence: true, numericality: 
      { greater_than_or_equal_to: 0, less_than_or_equal_to: :hp_max }
      

  
end
