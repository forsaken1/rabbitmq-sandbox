require "bunny"

# Start a communication session with RabbitMQ
conn = Bunny.new
conn.start

# open a channel
ch = conn.create_channel
ch.confirm_select

# declare a queue
q  = ch.queue("sms")
q.subscribe(manual_ack: true) do |delivery_info, metadata, payload|
  puts "This is the message: #{payload}"
  # acknowledge the delivery so that RabbitMQ can mark it for deletion
  ch.ack(delivery_info.delivery_tag)
end

# await confirmations from RabbitMQ, see
# https://www.rabbitmq.com/publishers.html#data-safety for details
# ch.wait_for_confirms

# give the above consumer some time consume the delivery and print out the message
sleep 0.1

puts "Done"

ch.close
conn.close
