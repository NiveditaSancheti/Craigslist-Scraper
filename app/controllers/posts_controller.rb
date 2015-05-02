class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json

  def home
    @posts = Post.all
    # @posts = @posts.group(:city).count

  end

  def index


    @posts = Post.order('created_date DESC').paginate(:page => params[:page], :per_page => 40)

    @posts = @posts.where(year: params["year"]) if params["year"].present?
    @posts = @posts.where("city like ?", "%#{params["city"]}%") if params["city"].present?

    @posts = @posts.where("price > ?", params["min_price"]) if params["min_price"].present?
    @posts = @posts.where("price < ?", params["max_price"]) if params["max_price"].present?

    @posts = @posts.where("milleage > ?", params["min_milleage"]) if params["min_milleage"].present?
    @posts = @posts.where("milleage < ?", params["max_milleage"]) if params["max_milleage"].present?

    @posts = @posts.where(make_vehicle: params["make_vehicle"]) if params["make_vehicle"].present?
    @posts = @posts.where(model_vehicle: params["model_vehicle"]) if params["model_vehicle"].present?

    @posts = @posts.where(type_vehicle: params["type_vehicle"]) if params["type_vehicle"].present?

    q = "%#{params["heading"]}%"
    @posts = @posts.where("heading like ? or body like ? or fuel_vehicle like ?  or city like ? or neighborhood like ?  or paint_color like ? or title_status like ? or transmission like ? ",q,q,q,q,q,q,q,q) if params["heading"].present?
    @posts = @posts.order("likeCount DESC,year DESC, dislikeCount ASC, price ASC, created_date DESC")
    # @posts = @posts.order(:year)
    # @posts = @posts.order(:rating)
    # @posts = @posts.order(:created_date).reverse_order

    @postsHashValue = @posts.select(:body).where("isDuplicate >= ", 0);

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @images = @post.images
    @postRecommendation = Post.where("rating = 5 and title_status= ? and heading not like '%span%' and make_vehicle in ('Nissan','Ford','Toyota','Hyundai')","clean").order('created_date DESC, price asc').first(5)
  @postRecommendation = Post.where("make_vehicle like ? and rating in (3,4,5) ", "%#{params["make_vehicle"]}%").order('rating DESC, created_date DESC, price DESC ').first(5) if params["make_vehicle"].present?


  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:heading, :body, :price, :neighborhood, :external_url, :timestamp)
    end


end
