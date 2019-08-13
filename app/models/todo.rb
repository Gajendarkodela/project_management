class Todo < ApplicationRecord
	belongs_to :project
	belongs_to :developer, optional: true
end
