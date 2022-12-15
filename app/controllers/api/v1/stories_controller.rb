class Api::V1::StoriesController < Api::V1::BaseController
  before_action :set_story, only: %i[show update destroy]

  def index
    @stories = Story.all.order(created_at: :desc)
    # render json: @stories
  end

  def show; end

  def update
    if @story.update(story_params)
      render :show, status: :created
    else
      render_error
    end
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @story.destroy
    render json: { message: 'story destroyed' }
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def render_error
    render json: { errors: @story.errors.full_messages }, status: :unprocessable_entity
  end

  def story_params
    params.require(:story).permit(:name, :text)
  end
end
