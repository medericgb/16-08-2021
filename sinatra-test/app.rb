require "sinatra"

url = "https://jsonplaceholder.typicode.com/post/1"

get "/" do
  "Hello world !"
end

get "https://jsonplaceholder.typicode.com/post/1" do
  content_type :json
  post.to_json
end
 