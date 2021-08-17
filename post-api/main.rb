require "rest-client"
require "json"
require "csv"

# Get all posts from remote url
posts_url = "https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20"
comments_url = "https://jsonplaceholder.typicode.com/post/5/comments"

list_comments = Array.new
all_comments = Array.new
comments_array = Array.new

for i in 1..20
  comment = "https://jsonplaceholder.typicode.com/post/#{i}/comments"
  list_comments.push(comment)
end

for comments_link in list_comments
  comments = RestClient.get(comments_link)
  all_comments.push(JSON.parse(comments))
  # puts comments.class
end

posts = RestClient.get(posts_url)
comments = RestClient.get(comments_url)

p all_comments

# Create CSV File for posts
def create_csv_doc(source, file_link)
  # Get all headers
  @headers = []
  JSON.parse(source).each do |h|
    h.keys.each do |key|
      @headers << key
    end
  end

  # Uniq headers
  uniq_headers = @headers.uniq
  finalrow = []

  JSON.parse(source).each do |h|
    final = {}
    @headers.each do |key2|
      final[key2] = h[key2]
    end
    finalrow << final
  end

  CSV.open(file_link , 'w') do |csv|
    csv << uniq_headers
    finalrow.each do |deal|
      csv << deal.values
    end
  end
end

# create_csv_doc(posts, 'posts.csv')
create_csv_doc(all_comments, 'comments.csv')