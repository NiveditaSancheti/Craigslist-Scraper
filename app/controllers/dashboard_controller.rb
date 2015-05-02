class DashboardController < ApplicationController
  respond_to :html, :js, :json
  def home

      #  @posts = Post.all
    #  @posts = Post.group(:city).count #city,  #count_all;
    #  @posts1 = Post.group(:year).count #year, #count_all
     @posts = Post.where("city like ?", "Anaheim").group(:year).count.to_a
     @posts1 = Post.group(:year).count.to_a #year, #count_all
     @postsCityPie = Post.group(:city).count.to_a
     @postsTagCloud = Post.where("make_vehicle is not null and year >= ?", "2011").group(:make_vehicle).count.to_a


     #count_all, year, make_vehicle : line bar chart
     @postsLine2011 = Post.where("year = ? and year is not null and make_vehicle is not null", "2011").group(:make_vehicle).count.to_a
     @postsLine2012 = Post.where("year = ? and year is not null and make_vehicle is not null", "2012").group(:make_vehicle).count.to_a
     @postsLine2013 = Post.where("year = ? and year is not null and make_vehicle is not null", "2013").group(:make_vehicle).count.to_a
     @postsLine2014 = Post.where("year = ? and year is not null and make_vehicle is not null", "2014").group(:make_vehicle).count.to_a
     @postsLine2015 = Post.where("year = ? and year is not null and make_vehicle is not null", "2015").group(:make_vehicle).count.to_a
     @postsLine = Post.select(:make_vehicle).where("year >= ? and  year is not null and make_vehicle is not null", "2011").uniq


  #   sql = "select distinct make_vehicle from posts where year >= '2011' and year is not null and and make_vehicle is not null"
  ##   records_array = ActiveRecord::Base.connection.execute(sql);

   #  @postsFraudPie = Post.where("flagged_status = ?", 1).group(:city).count.to_a  -- displaying frauds per year

     ############# BUBBLE CHART
     @postsBubbleFraud = Post.where("flagged_status = ? and year >= ? and year is not null", 1,"2011").group(:year).count.to_a
     @postsBubbleDuplicate = Post.where("isDuplicate = ? and year >= ? and year is not null", 1,"2011").group(:year).count.to_a
     @postsBubbleCount = Post.where(" year >= ? and year is not null","2011").group(:year).count.to_a




    @postTree =  Post.where("year >= ? and make_vehicle is not null and year is not null ", "2011").group(:city).group(:make_vehicle).group(:fuel_vehicle).count.to_json


#@postsCityPie = Post.where("make_vehicle like ? and city: ", "%#{params["make_vehicle"]}%",["San Jose","San Francisco"]).group(:city).count.to_a
@postsCityPie = Post.where("city in (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) and make_vehicle like ?","Santa Clara","Sunnyvale","South San Francisco","San Jose","San Francisco","Sacramento",
"Roseville","Hayward","Redwood city","Oakland","Menlo park","Half moon bay","Fremont","Dublin","Daly city","Cupertino", "%#{params["make_vehicle"]}%").group(:city).count.to_a

#@postsCityPie = Post.group(:city).count.to_a #works for general city n count

#@postsLine2015_C = Post.where("make_vehicle is not null and created_month = ? ", "April").group(:make_vehicle).count.to_a
#@postsLine2015_mar = Post.where("make_vehicle is not null and created_month = ? ", "March").group(:make_vehicle).count.to_a
#@postsLine2015_feb = Post.where("make_vehicle is not null and created_month = ? ", "February").group(:make_vehicle).count.to_a
#@postsLine2015_jan = Post.where("make_vehicle is not null and created_month = ? ", "January").group(:make_vehicle).count.to_a

#@postsLine2015_C = Post.where("make_vehicle is not null and created_day = ? ", Time.now.day).group(:make_vehicle).count.to_a
#@postsLine2015_M = Post.where("make_vehicle is not null and created_day = ? ", 26).group(:make_vehicle).count.to_a
#@postsLine2015_W = Post.where("make_vehicle is not null and created_day between ? and ? ",25,26 ).group(:make_vehicle).count.to_a
#@postsLine2015_tag = Post.where("make_vehicle is not null and (created_day between ? and ?  or created_month = ?)",25,26, "April" ).group(:make_vehicle).count.to_a

#Posts per day
@postsLine2015_C = Post.where("created_month = ? ", "April").group(:make_vehicle).count.to_a
@postsLine2015_M = Post.where("created_day = ? and created_month = ?", 29, "April").group(:make_vehicle).count.to_a
@postsLine2015_W = Post.where("created_day between ? and ? and created_month = ?",20,26,"April" ).group(:make_vehicle).count.to_a
@postsLine2015_tag = Post.where("created_day between ? and ?  or created_month = ?",20,29, "April" ).group(:make_vehicle).count.to_a
####including params



  #FRAUD COUNT WHEN NOTHING SELECTED
     @postsLineMay = Post.where("created_month = ? and created_month is not null and flagged_status = 1", "May").group(:city).count.to_a
     @postsLineApril = Post.where("created_month = ? and created_month is not null and flagged_status = 1", "April").group(:city).count.to_a
     @postsLineMarch = Post.where("created_month = ? and created_month is not null and flagged_status = 1", "March").group(:city).count.to_a
     @postsLineFeb = Post.where("created_month = ? and created_month is not null and flagged_status = 1", "February").group(:city).count.to_a
     @postsLineJan = Post.where("created_month = ? and created_month is not null and flagged_status = 1", "January").group(:city).count.to_a
     #FRAUD COUNT WHEN SOME MAKE SELECTED
     @postsLineMay = Post.where("created_month = ? and created_month is not null and flagged_status = 1 and make_vehicle like ?", "May", "%#{params["make_vehicle"]}%").group(:city).count.to_a if params["make_vehicle"].present?
     @postsLineApril = Post.where("created_month = ? and created_month is not null and flagged_status = 1 and make_vehicle like ?", "April", "%#{params["make_vehicle"]}%").group(:city).count.to_a if params["make_vehicle"].present?
     @postsLineMarch = Post.where("created_month = ? and created_month is not null and flagged_status = 1 and make_vehicle like ?", "March", "%#{params["make_vehicle"]}%").group(:city).count.to_a if params["make_vehicle"].present?
     @postsLineFeb = Post.where("created_month = ? and created_month is not null and flagged_status = 1 and make_vehicle like ?", "February", "%#{params["make_vehicle"]}%").group(:city).count.to_a if params["make_vehicle"].present?
     @postsLineJan = Post.where("created_month = ? and created_month is not null and flagged_status = 1 and make_vehicle like ?", "January", "%#{params["make_vehicle"]}%").group(:city).count.to_a if params["make_vehicle"].present?
     #X AXIS for FRAUD CHART
      @postsLineCity = Post.select(:city).where("flagged_status = 1").order(:city).uniq

  @postsTreeMap = Post.where("fuel_vehicle is not null and make_vehicle = ?", "BMW").group(:fuel_vehicle).count.to_a

# clear, salvage , status , render with where param
    if params["hBarParam"] == "Today"
         postsHBarParam = "created_day = 29"
    elsif params["hBarParam"] == "Weekly"
      postsHBarParam = "created_day between 20 and 27"
    else
     postsHBarParam = "created_month = 'April'"
    end
 #   postsHBarParam = "created_day = 26"
    @postsHBarClean = Post.where(postsHBarParam + " and title_status like ? and make_vehicle is not null", "clean").group(:make_vehicle).count.to_a
    @postsHBarSalvage = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "salvage").group(:make_vehicle).count.to_a
    @postsHBarPartsOnly = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "parts only").group(:make_vehicle).count.to_a
    @postsHBarRebuilt = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "rebuilt").group(:make_vehicle).count.to_a
    @postsHBarLien = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "lien").group(:make_vehicle).count.to_a
    @postsHBar = Post.select(:make_vehicle).where(postsHBarParam +" and title_status is not null and make_vehicle is not null" ).uniq

    #@postsPriceTest = Post.where("make_vehicle = ? and model_vehicle = ?","Ford","Ranger").group("make_vehicle,model_vehicle,year").average(:price)

     @postsPriceTest = Post.where("model_vehicle like ?","%#{params["avgPriceSelect"]}%").group("make_vehicle,model_vehicle,year").average(:price)

    @postPriceSelectModel = Post.select("make_vehicle,model_vehicle").where("price <> ?",0).uniq.order(:make_vehicle).to_a
    @postRecommendation = Post.where("rating = 5 and title_status= ? and heading not like '%span%' and make_vehicle in ('Nissan','Ford','Toyota','Hyundai')","clean").order('created_date DESC, price asc').first(5)
      @postRecommendation = Post.where("make_vehicle like ? and rating in (3,4,5) ", "%#{params["make_vehicle"]}%").order('rating DESC, created_date DESC, price DESC ').first(5) if params["make_vehicle"].present?


  end

  def hbar
       puts params["hBarParam"]
       if params["hBarParam"] == "Today"
            postsHBarParam = "created_day = 26"

       elsif params["hBarParam"] == "Monthly"
         postsHBarParam = "created_month = 'April'"
       else
        postsHBarParam = "created_day between 22 and 27"
       end
       puts postsHBarParam
    #   postsHBarParam = "created_day = 26"


       @postsHBarClean = Post.where(postsHBarParam + " and title_status like ? and make_vehicle is not null", "clean").group(:make_vehicle).count.to_a
       @postsHBarSalvage = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "salvage").group(:make_vehicle).count.to_a
       @postsHBarPartsOnly = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "parts only").group(:make_vehicle).count.to_a
       @postsHBarRebuilt = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "rebuilt").group(:make_vehicle).count.to_a
       @postsHBarLien = Post.where(postsHBarParam +" and title_status like ? and make_vehicle is not null", "lien").group(:make_vehicle).count.to_a
       @postsHBar = Post.select(:make_vehicle).where(postsHBarParam +" and title_status is not null and make_vehicle is not null" ).uniq.to_a
       puts @postsHBarClean

   respond_to do |format|
     format.js { render @postsHBarClean.to_json }
        format.html
      end
    end
end
