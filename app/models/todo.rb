class Todo < ApplicationRecord
	belongs_to :project
	belongs_to :developer, optional: true

	validates :description, presence: true

	module Status
		NEW = 'New'
		INPROGRESS = 'InProgress'
		DONE = 'Done'
	end
end
