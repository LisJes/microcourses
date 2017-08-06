class User < ApplicationRecord
	has_many :organized_events, class_name: "Event", dependent: :destroy
	#LIJ: add dependent destroy to ensure that once a user is deleted from the database, the same happens with his events
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #LIJ: Wenn event.organizer aufgerufen wird, soll Username widergegeben werden
	def to_s
		"#{username}"
	end

end
