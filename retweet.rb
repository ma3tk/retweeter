require 'twitter'

# Set specific screen_name
screen_name = ""

# Input yours
client = Twitter::REST::Client.new(
  consumer_key:        '',
  consumer_secret:     '',
  access_token:        '',
  access_token_secret: '',
)

# Get since_id from text file
File.foreach('since_id.txt') do |id|
  since_id = id.delete("\n")
end

# As you like!
options = {
  "since_id" => since_id,
  "count" => 30,
}

# Get timeline
timeline = client.user_timeline(screen_name, options)

# Nothing to retweet
if timeline.length == 0 then 
  exit
end

# To preserve latest ID
latest_id = timeline[0].id

# To start retweeting from old tweet 
timeline = timeline.reverse

# 
timeline.each{|tl| 
=begin
  # If you want not to retweet that includes specific word
  if !tl.text.index("") then
    client.retweet(tl)
  end
=end
 client.retweet(tl)
}

# Update new since_id to text file
File.open("since_id.txt", "w") do |file|
  file.print(latest_id)
end
