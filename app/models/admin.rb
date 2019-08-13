class Admin < User
	has_many :projects
	has_many :todos
end