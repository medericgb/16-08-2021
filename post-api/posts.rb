require "rest-client"
require "json"
require "csv"

# Get all posts from remote url
posts_url = "https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20"

posts = RestClient.get(posts_url)

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

create_csv_doc(posts, 'posts.csv')