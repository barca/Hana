class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  # GET /classrooms
  # GET /classrooms.json
  def index
    #determine ordering of classrooms
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
      ordering = :name
    when 'occupancy'
      ordering = 'max_occupancy DESC'
    end

    if params[:sort] != session[:sort]
      session[:sort] = sort
    end
    @classrooms = Classroom.all.order(ordering)
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def available
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
      ordering = :name
    when 'occupancy'
      ordering = 'max_occupancy DESC'
    end
    
    if params[:sort] != session[:sort]
      session[:sort] = sort
    end

    if params[:day] != nil
      @date = Date.new(params[:day]['get(1i)'].to_i,params[:day]['get(2i)'].to_i,params[:day]['get(3i)'].to_i)
    else
      @date = Date.today
    end

    if params[:starts_at] != nil
      @start_time = Time.parse "2000-01-01 #{params[:starts_at]['get(4i)']}:#{params[:starts_at]['get(5i)']}"
    else
      @start_time = Time.now
    end

    if params[:ends_at] != nil
      @end_time = Time.parse "2000-01-01 #{params[:ends_at]['get(4i)']}:#{params[:ends_at]['get(5i)']}"
    else
      @end_time = Time.now
    end

    @classrooms = Classroom.all
    @available_classrooms = dailyAvailableClassrooms(@date)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def dailyAvailableClassrooms(date)
      availables = []
      allRooms = Classroom.all
      allRooms.each do |classroom|
        if classNotOccupiedOnDay(classroom, date)
          availables << classroom
        end
      end
      return availables
    end


    def classNotOccupiedAtTime(classroom, date, start, finish)
      #build of off classNotOccupiedOnDay
    end

    def classNotOccupiedOnDay(classroom, date)
      days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
      dayOfWeek = days_of_week[(date.wday)]
      #currently only returns classes available on a specific day
      @lessons=Lesson.find_by_sql("SELECT * FROM \"lessons\"  
                        WHERE  (\"lessons\".\"start_date\" = \'#{date}\'
                                OR \"lessons\".\"#{dayOfWeek}\" = \'t\')
                            AND \"lessons\".\"location\" == \'#{classroom.name}\'")
      if @lessons == []
        return true
      else
        return false
      end      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:name, :max_occupancy, :details, :color)
    end
end



