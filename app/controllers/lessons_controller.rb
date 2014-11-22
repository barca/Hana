class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all

    @lessons13 = Lesson.where(g1_3: true)
    @lessons35 = Lesson.where(g3_5: true)
    @lessons68 = Lesson.where(g6_8: true)

    #find date span to display on calendar
    @start_date = params[:start_date] || session[:start_date] || {}
    if @start_date == {}
      @start_date = Date.today
    end

    if params[:start_date] != session[:start_date]
      session[:start_date] = @start_date
      redirect_to :start_date => @start_date and return
    end

  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new

    #generate list of classrooms to select from for location
    @classrooms = Classroom.all
    @roomsList = [[]]
    @classrooms.each do |classroom|
      @roomsList << [classroom.name]
    end
    @classroomSelect = @roomsList
  end

  # GET /lessons/1/edit
  def edit
    #generate list of classrooms to select from for location
    @classrooms = Classroom.all
    @roomsList = [[]]
    @classrooms.each do |classroom|
      @roomsList << [classroom.name]
    end
    @classroomSelect = @roomsList
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    #generate list of classrooms to select from for location
    @classrooms = Classroom.all
    @roomsList = [[]]
    @classrooms.each do |classroom|
      @roomsList << [classroom.name]
    end
    @classroomSelect = @roomsList

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    #generate list of classrooms to select from for location
    @classrooms = Classroom.all
    @roomsList = [[]]
    @classrooms.each do |classroom|
      @roomsList << [classroom.name]
    end
    @classroomSelect = @roomsList

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :instructor, :starts_at, :ends_at, :location, :max_enrollment, :description, :g1_3, :g3_5, :g6_8, :mon, :tue, :wed, :thu, :fri, :end_date)
    end
end
