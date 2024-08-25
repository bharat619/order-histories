# frozen_string_literal: true

class GenerateOrderCsvJob
  include Sidekiq::Job

  sidekiq_options retry: 0

  def perform(user_id)
    records = scope.where(user_id:)
                   .select('username,email,code,products.name as product_name,
              categories.name as category_name, orders.created_at as order_date')

    ActionCable.server.broadcast('order_stream', formatted_data(records))
  end

  private

  def formatted_data(records)
    order_records = []
    records.map do |r|
      date = r.order_date
      date = DateTime.parse(date).strftime('%d-%m-%Y')
      order_records << { username: r.username,
                         email: r.email,
                         code: r.code,
                         product_name: r.product_name,
                         category_name: r.category_name,
                         order_date: date }
    end
    order_records
  end

  def scope
    Order.joins(:user, product: :category)
  end
end
