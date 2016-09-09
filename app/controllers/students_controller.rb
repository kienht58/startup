class StudentsController < ApplicationController
	before_action :set_student, only: [:show, :edit, :update, :destroy]

	def index
	  @students = Student.all
	end

	def show
	end


	def new
	  @student = Student.new
#          @email = current_user.email
#          @student.email = 'bbbbbb'
#          @student.save
	end


	def edit
	end


	def create
		@student = Student.new(student_params)

		respond_to do |format|
			if @student.save
				format.html { redirect_to @student, notice: 'A new student was successfully created.' }
				format.json { render :show, status: :created, location: @student }
			else
				format.html { render :new }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end


	def update
		respond_to do |format|
			if @student.update(student_params)
				format.html { redirect_to @student, notice: "A student's profile was successfully updated." }
				format.json { render :show, status: :ok, location: @student }
			else
				format.html { render :edit }
				format.json { render json: @student.errors, status: :unprocessable_entity }
			end
		end
	end


	def destroy
		@student.destroy
			respond_to do |format|
			format.html { redirect_to students_url, notice: 'A student was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

  def searchtop
    @student = Search::Student.new
  end

  def search
    @student = Search::Student.new(search_params)
    @students = @student
     .matches
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
	@student = Student.find(params[:id])
    end

    def student_params
	params.require(:student).permit(:name, :university, :major, :interestedfield, :history, :achievement, :hope, :email)
    end

  def search_params
      params
      .require(:search_student)
      .permit(Search::Student::ATTRIBUTES)
  end

end
