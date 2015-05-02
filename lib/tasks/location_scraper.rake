desc "Fetch craigslist data from 3taps"
task scrape: :environment do

require 'open-uri'
require 'json'

# Set API token and URL
auth_token = "ca9d1ebd6d17828c658f0ef293e6a474"
polling_url = "http://polling.3taps.com/poll"
anchor_url = "http://polling.3taps.com/anchor"

# Specify request  parameters for anchor url\
anchor_params = {
  auth_token: auth_token,
  timestamp:1428969600#1426420800 #1426377600
}
#1985469445
anchor_uri = URI.parse(anchor_url)
anchor_uri.query = URI.encode_www_form(anchor_params)

# Submit request
anchor_result = JSON.parse(open(anchor_uri).read)
#anchor = anchor_result.first["anchor"]
puts anchor_result  # to_s converts to string

# Grab data until up-to-date
#loop do

  # Specify request  parameters for polling url
  params = {
    auth_token: auth_token,
    # anchor:anchor_result["anchor"], # temp change #3/15/2015
    # The following achor retrieves values from database, which is currently '2055547657'
    anchor: anchor_result["anchor"],#Anchor.first.value,
    source: "CRAIG",
    category_group: "VVVV",
    category: "VAUT",
    'location.state' => "USA-CA",
    retvals: "id,account_id,source,category,category_group,location,external_id,external_url,heading,body,timestamp,timestamp_deleted,expires,language,price,currency,images,annotations,status,state,immortal,deleted,flagged_status"
  }

  #http://polling.3taps.com/anchor?auth_token=ca9d1ebd6d17828c658f0ef293e6a474&

  # Prepare API request
  uri = URI.parse(polling_url)
  uri.query = URI.encode_www_form(params)

  # Submit request
  result = JSON.parse(open(uri).read)

  # Display results to screen
  # this displays ll data in terminal
  # puts results
  #puts JSON.pretty_generate result
  # puts JSON.pretty_generate result["postings"]
   #puts JSON.pretty_generate result["postings"].first
   #puts JSON.pretty_generate result["postings"].second

  # puts JSON.pretty_generate result["postings"].first["heading"] --> this will give error cos output need to be displayed in string

  # puts result["postings"].first["heading"] # dis output as string
  # puts result["postings"].first["body"] # dis
  # puts result["postings"].second["location"]["locality"] # dis

  # Saving outpout to file
  # output = File.open( "outputfile.json","w" )
  # output << result
  # output.close

    result["postings"].each do |posting|

    # Create new Post
      @post = Post.new

        @post.heading = posting["heading"]
        @post.body = posting["body"]
        @post.price = posting["price"]
        #@post.neighborhood = posting["location"]["locality"]
        @post.external_url = posting["external_url"]
        @post.year = posting["annotations"]["year"]  	if posting["annotations"]["year"].present?
        @post.phone = posting["annotations"]["phone"]  if posting["annotations"]["phone"].present?
        @post.paint_color = posting["annotations"]["paint_color"] if posting["annotations"]["paint_color"].present?
        @post.drive = posting["annotations"]["drive"] if posting["annotations"]["drive"].present?
        @post.flagged_status = posting["flagged_status"] if posting["flagged_status"].present?
        @post.fuel_vehicle = posting["annotations"]["fuel"] if posting["annotations"]["fuel"].present?
        @post.model_vehicle = posting["annotations"]["model"] if posting["annotations"]["model"].present?
        @post.make_vehicle = posting["annotations"]["make"] if posting["annotations"]["make"].present?
        @post.title_status = posting["annotations"]["title_status"] if posting["annotations"]["title_status"].present?
        @post.fuel_vehicle = posting["annotations"]["fuel"] if posting["annotations"]["fuel"].present?
        @post.model_vehicle = posting["annotations"]["model"] if posting["annotations"]["model"].present?
        @post.make_vehicle = posting["annotations"]["make"] if posting["annotations"]["make"].present?
        @post.title_status = posting["annotations"]["title_status"] if posting["annotations"]["title_status"].present?
        @post.transmission = posting["annotations"]["transmission"] if posting["annotations"]["transmission"].present?
        @post.mileage = posting["annotations"]["mileage"] if posting["annotations"]["mileage"].present?
        @post.account_id = posting["annotations"]["source_account"] if posting["annotations"]["source_account"].present?
        @post.isDuplicate = 0 ## logiccc #posting["annotations"]["source_account"] if posting["annotations"]["source_account"].present?
        @post.source_map_google  =  posting["annotations"]["source_map_google"] if posting["annotations"]["source_map_google"].present?
        @post.created_date = posting["timestamp"]
        # @post.state = posting["location"]["state"]
        # @post.city = posting["location"]["city"]
        # @post.zipcode = posting["location"]["zipcode"]
        @post.neighborhood =Location.find_by(code: posting["location"]["locality"]).try(:shortName)
        @post.state = "California"
        @post.city =Location.find_by(code: posting["location"]["city"]).try(:shortName)
        @post.zipcode =Location.find_by(code: posting["location"]["zipcode"]).try(:shortName)


         # @post.id = posting["id"]
    #  @post.account_id = posting["account_id"]

    #@post = Post.new
    # @post.source = posting["source"]
    # @post.category = posting["category"]
    # @post.category_group = posting["category_group"]
    # @post.location_state = posting["location"]["state"]
    # @post.location_city = posting["location"]["city"]
    # @post.external_id = posting["external_id"]
    # @post.external_url = posting["external_url"]
    # @post.heading = posting["heading"]
    # @post.body = posting["body"]
    # @post.timestamp = posting["timestamp"]
    # @post.timestamp_deleted = posting["timestamp_deleted"]
    # @post.expires = posting["expires"]
    # @post.language = posting["language"]
    # @post.price = posting["price"]
    # @post.currency = posting["currency"]
    # @post.status = posting["status"]
    # @post.state = posting["state"]
    # @post.immortal = posting["immortal"]
    # @post.deleted = posting["deleted"]
    # @post.flagged_status= posting["flagged_status"]


    # Save Post
    ### need logic
      @post.rating = Random.new.rand(1..5)

     @post.save
     posting["images"].each do |image|
      @image = Image.new
      @image.url = image["full"]
      @image.post_id = @post.id
      @image.save

    end

  end

#   Anchor.first.update(value: result["anchor"])
#   puts Anchor.first.value
#   break if results["postings"].empty?
# end
end
