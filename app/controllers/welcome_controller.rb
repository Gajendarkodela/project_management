class WelcomeController < ApplicationController
	def index
		if current_user.admin?
			redirect_to projects_path
    else
    	redirect_to todos_path
    end

	end
end