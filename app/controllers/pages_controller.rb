class PagesController < ApplicationController
  def about
    @postRecommendation = Post.where("make_vehicle like ?", "%#{params["make_vehicle"]}%").first(5)

  end

  def contact
    @postRecommendation = Post.where("make_vehicle like ?", "%#{params["make_vehicle"]}%").first(5)

  end
end
