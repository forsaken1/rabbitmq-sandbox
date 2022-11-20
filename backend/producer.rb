require 'bunny'

class Producer
  QUEUE_NAME = 'sms'

  attr_accessor :conn, :channel, :queue

  def initialize
    self.conn = Bunny.new host: ENV['RABBIT_HOST']
    conn.start

    self.channel = conn.create_channel
    channel.confirm_select

    self.queue = channel.queue(QUEUE_NAME)
  end

  def send(payload)
    queue.publish(payload)
  end

  def close
    channel.close
    conn.close
  end
end
