require "bunny"

# Start a communication session with RabbitMQ
conn = Bunny.new
conn.start

# open a channel
ch = conn.create_channel
ch.confirm_select

# declare a queue
q  = ch.queue("sms")

# publish a message to the default exchange which then gets routed to this queue
q.publish("sms")

# await confirmations from RabbitMQ, see
# https://www.rabbitmq.com/publishers.html#data-safety for details
# ch.wait_for_confirms

ch.close
conn.close

puts "Done"
