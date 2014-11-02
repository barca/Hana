class ClassroomsController < ApplicationController
	def new
	end

	def create
		@classroom = Classroom.new(classroom_params)

		@classroom.save
		redirect_to classrooms_path
	end

	def index
		@classrooms = Classroom.all
	end

	def show
		@classroom = Classroom.find(params[:id])
	end

	def edit
		@classroom = Classroom.find(params[:id])
	end

	def update
		@classroom = Classroom.find(params[:id])

		if @classroom.update(classroom_params)
			redirect_to @classroom
		else
			render 'edit'
		end
	end

	def destroy
		@classroom = Classroom.find(params[:id])
		@classroom.destroy

		redirect_to classrooms_path
	end

	private
	  def classroom_params
	  	params.require(:classroom).permit(:name, :max_enrollment, :details)
	  end
end
