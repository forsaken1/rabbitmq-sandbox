require "bunny"

class SmsService
  RECONNECT_AFTER = 5
  QUEUE_NAME = 'sms'

  attr_accessor :conn, :channel, :queue

  def call
    connect
    create_channel
    create_queue
    listen
    close
  end

  private

  def connect
    loop do
      self.conn = Bunny.new
      conn.start

      puts 'Connected'
      break
    rescue Bunny::TCPConnectionFailed, AMQ::Protocol::EmptyResponseError
      puts 'Retry..'
      sleep RECONNECT_AFTER
    end
  end

  def create_channel
    self.channel = conn.create_channel
    channel.confirm_select
    puts 'Channel created'
  end

  def create_queue
    self.queue = channel.queue(QUEUE_NAME)
    puts 'Queue created'
  end

  def listen
    loop do
      queue.subscribe(manual_ack: true) do |delivery_info, metadata, payload|
        puts "This is the message: #{payload}"
        # acknowledge the delivery so that RabbitMQ can mark it for deletion
        channel.ack(delivery_info.delivery_tag)
      end
      sleep 1
    end
  end

  def close
    channel.close
    conn.close
    puts 'Closed'
  end
end

SmsService.new.call

# await confirmations from RabbitMQ, see
# https://www.rabbitmq.com/publishers.html#data-safety for details
# ch.wait_for_confirms
