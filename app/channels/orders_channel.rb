class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'order_stream'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    #
  end

  def received(_message)
    puts messages
  end
end
