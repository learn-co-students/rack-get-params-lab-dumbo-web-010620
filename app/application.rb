class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #makes path....or... checks for path? have to add onto this if statement.
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term) #finds search term, and writes the input?
      #------------------------added new code----------#
      #sets required path /extension to /cart??
    elsif req.path.match(/cart/)
      if @@cart.empty? #if this returns "true", writes the following response, or else parses. 
        resp.write "Your cart is empty" #have to get more familiar with "?" boolean methods.
      else 
        @@cart.each do |stuff|
          resp.write "#{stuff}\n" # iterates through each stuff in the cart. n outputs in a new line.
        end
      end
    elsif req.path.match(/add/)
      add_to_cart = req.params["item"]
      if @@items.include?(add_to_cart)
        @@cart << add_to_cart
        resp.write "added #{add_to_cart}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish # finishes the function that uses "Rack power"
  end

  #handles search parameters??
  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
