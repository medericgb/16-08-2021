require "rest-client"
require "json"
require "csv"

array_link = []
for key in 1..20
  url = "https://jsonplaceholder.typicode.com/posts/#{key}/comments"
  array_link.push(url)
end

array_values_link = []

for values in array_link
  read_url = RestClient.get(values)
  array_values_link.push(JSON.parse(read_url))
end

head = array_values_link[0][0]
collect = []
head.each do |index, value|
  collect.push(index)
end

array_comment = []
array_values_link.each do |values|
  values.each do |response|
    array_comment.push(response)
  end
end

CSV.open("comments.csv" , "wb") do |csv|
  csv << collect
  array_comment.each do |element|
    csv << element.values
  end
end