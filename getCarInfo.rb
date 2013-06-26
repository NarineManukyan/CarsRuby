#
#  getCarInfo.rb
#  
#
#  Created by Narine Manukyan on 06/26/2013.
#  Copyright (c) 2013 UVM. All rights reserved.

require 'rubygems'
require 'osx/cocoa'
require 'fastercsv'
require 'open-uri'

make = []
model = []
year = []

FasterCSV.open("Vehicles2013.csv","w") do |csv|
    headers = Array.[]('Make', 'Model','Year','City mileage','Highway mileage','Minimum Price','Maximum Price')
    csv<<headers


FasterCSV.foreach("vehicles.csv") do |row|
    
    if row[0]==nil || row[1] == nil || row[2] == nil
        #puts "Not enough data"
        x = Array.[]( row[0], row[1], row[2], nil, nil, nil, nil)
        csv << x

    else
        link = "http://www.cars.com/"+row[0].downcase+"/"+row[1].downcase+"/"+row[2]+"/"
        
        begin
        open(link) {|page| page_content = page.read()
        city = page_content.scan(/City:.*?(\d{2})/m)
        highway = page_content.scan(/Highway:.*?(\d{2})/m)
        priceMin = page_content.scan(/resizable,scrollbars'.*?(\d{1,3}\,\d{1,3})/m)
        priceMax = page_content.scan(/resizable,scrollbars'.*?\d{1,3}\,\d{1,3}.*?(\d{1,3}\,\d{1,3})/m)
        puts link
        
        x = Array.[]( row[0], row[1], row[2], city, highway, priceMin, priceMax)
        csv << x
        }
        rescue
            #puts "Wrong make, model or year"
            x = Array.[]( row[0], row[1], row[2], nil, nil, nil, nil)
            csv << x
        end
    end
    
    

end
end


 

