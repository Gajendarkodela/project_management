class Developer < User
	has_and_belongs_to_many :projects
	has_many :todos

	validates :email, uniqueness: true
	validates :name, uniqueness: true
end