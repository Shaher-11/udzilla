class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy delete_video ]

  def delete_video
    authorize @lesson, :edit?
    @lesson.video.purge
    @lesson.video_thumbnail.purge
    redirect_to course_lesson_path(@course, @lesson), notice: "Succefully Deleted!"
  end

  def sort
    @course = Course.friendly.find(params[:course_id])
    lesson = Lesson.friendly.find(params[:lesson_id])
    authorize lesson, :edit?
    lesson.update(lesson_params)
    render body: nil
  end

  def index
    @lessons = Lesson.all
  end

  def show
    authorize @lesson
    current_user.view_lesson(@lesson)
  end

  def new
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.new
  end

  def edit
    authorize @lesson
  end

  def create
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.new(lesson_params)
    @lesson.course_id = @course.id
    authorize @lesson
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @lesson
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @lesson
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_lesson
      @course = Course.friendly.find(params[:course_id])
      @lesson = Lesson.friendly.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :row_order_position, :video, :video_thumbnail)
    end
end
