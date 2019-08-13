class Project < ApplicationRecord
	belongs_to :admin
	has_many :todos
	has_and_belongs_to_many :developers

	validates :name, uniqueness: {scope: :admin_id},presence: true

	def developers
		Developer.where(id: self.developer_ids)
	end
end
