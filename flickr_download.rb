#
#  Download photos belonging to some group
#        jssmk @ Helsinki Hacklab
#

# Start with editing your locals.rb file, use locals_default.rb as a template
require_relative 'locals'

local_pic_list = Dir[PIC_path+"**{.JPG,.jpg}"]


require 'flickraw'
#require 'exifr'
require 'logger'
require 'open-uri'

# Logfile
$mylog = Logger.new(LOG_path+'flickr_download_log.txt', 10, 1024000)
$mylog.info("Start ---->")

# If there is no internet connection, exit
begin
  # We trust google is up
  open("http://www.google.com")
rescue
  $mylog.info("---> no internet connection")
  exit
end


FlickRaw.api_key = MY_api_key
FlickRaw.shared_secret = MY_shared_secret


# List all photos in the group
$group_pic_list = flickr.groups.pools.getPhotos api_key: FlickRaw.api_key, group_id: MY_group_id
$mylog.info("Number of pics to download "+$group_pic_list.length.to_s)


for pic in $group_pic_list
  
  if local_pic_list.include?(PIC_path+pic.id+'.jpg')
    # This pic is already downloaded
  else

    info = flickr.photos.getInfo api_key: MY_api_key, photo_id: pic.id
    $mylog.info("getting info for pic: " + pic.id)
  
    print("Downloading pic: " + info.title + "\n")

    begin
      sizes = flickr.photos.getSizes api_key: MY_api_key, photo_id: pic.id
    rescue FlickRaw::FailedResponse => e
      $mylog.error("getting sizes for pic " + pic.id + " failed")
      exit
    end
    
    org_size = sizes.size.select {|s| s.label == 'Original'}[0]
     
    # Start downloading
    
    open(PIC_path + pic.id + '.jpg', 'wb') do |file|
      file << open(org_size.source).read
    end
    
    $mylog.info("downloaded pic: "+pic.id)
  end
end

$mylog.info("----> End")
