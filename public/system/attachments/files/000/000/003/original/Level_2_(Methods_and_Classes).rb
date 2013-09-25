# Optional Arguments #hash 

=begin 
  Instead of remembering all the optional parameters to skip to following optional arguments in most languages, Ruby allows you to use hash arguments to make it more clear how everythings works 
  


=end

def tweet(message, options = {})
    status = Status.new 
    status.lat = options[:lat] 
    status.long = options[:long]
    status.body = message
    status.reply_id = options[:reply_id]
    status.post
  end 

tweet("Practicing Ruby-Fu!"), lat: 28.55, long: -81.33, reply_id: 227946) 



#Exceptions 

=begin 
 When an empty array or empty values can mean two different things based on your code, it's probably better to create use an exception like I learned from Treehouse. 
def get_tweets(list)
  if list.authorized?(@users)
    list.tweets
  else 
    []
  end 
end 

tweets = get_tweets(my_list)

if tweets.empty?
  alert "No tweets were found" + "Are you authorized to access this list?" 
end 


=end 

def get_tweets(list)
  unless list.authorized?(@user)
    raise AuthorizationException.new 
  end 
  list.tweets
end 

begin tweets = get_tweets(my_list)
  rescue AuthorizationException
    warn "You are not authorized to access this list" 
end 



# You now KNOW there's a problem. 

#Splat Arguments =: Indicated by '*' before the variable  in  Ruby 

def mention(status, *names)
  tweet("#{names.join(' ')} #{status}")
end 

mention("Your courses rocked!", "eallam", "greggpollack", "jasonvanlue")



#Why we need classes is to deal with edge cases so your users don't have to is one common criteria


class name 
  def initialize(first, last = nil) 
    @first = first 
    @last = last 
  end 

  def format
    [@last, @first].compact.join(', ')
  end 

  def to_s
    "#{@status}\n#{@created_at}"
  end 
  
end 

#You can then output things correctly

user_names = [] 
user_names << Name.new('Ashton', 'Kutcher')
user_names << Name.new('Wil', 'Wheaton')
user_names << Name.new('Madonna')
user_names.each { |n| puts n.format } 

#Re-opening Classes 


