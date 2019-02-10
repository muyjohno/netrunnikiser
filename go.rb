require './netrunnikers/card'
require 'csv'

folder = "./example/"
prefix = "EG"

CSV.foreach("#{folder}cards.csv") do |row|
  print "#{row[1]}..."

  number = prefix + row[0].rjust(3, "0")
  Netrunnikers::Card.build!(
    title: row[1],
    description: row[4],
    category: row[3].upcase,
    points: row[2],
    number: number
  ).write("#{folder}#{number}.jpg")

  puts "Done"
end
