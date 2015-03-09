# Queue.coffee
#
# I built this to help with some Node.js data processing- I had a list of addresses to geocode
# And didn't want to run into google's rate limiting. So I set up a queue to process each address
# and to add a short timeout in between each request (1000ms)
#
# A simple example: 
# queue = new Queue()
# queue.add (next) ->
#   setTimeout next, 1000
#
# queue.onDone ->
#   console.log "Queue's complete"
#
# queue.start()
#

class Queue
  #Important things to know about a queue
  # 1. Add functions to a queue using the queue.add(fn)
  # 2. Each queued function needs to take one parameter which must be executed when it is done processing
  # 3. Use queue.onDone to add functions when the queue is done processing data
  constructor: ->
    @queue = []
    @after = []
    @index = -1

  # Functions that are added to the queue must take a function as the only parameter
  # For example: function(next){ doSomething(); next() };
  # After the function has been executed, it will continue execution of the queue
  add: (fn) ->
    @queue.push fn

  start: ->
    #Kick off the queue
    @index = 0
    @next()

  next: ->
    #This is the function that gets passed into the next function
    return @done() if @index >= @queue.length
    fn = @queue[@index]
    fn =>
      @index++
      @next()

  done: ->
    for fn in @after
      fn()

  onDone: (fn) ->
    @after.push fn
