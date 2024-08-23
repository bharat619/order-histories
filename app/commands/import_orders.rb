# frozen_string_literal: true

class ImportOrders
  include Interactor
  include LogUtils

  CSV_PATH = Rails.root.join('data', 'order_details.csv')

  def call
    Rails.logger.info 'Importing user data'
    count = 0
    csv_data.each do |order|
      email, product_code, created_at = order
      user = User.find_by(email:)
      next if user.blank?

      product = Product.find_by(code: product_code)
      next if product.blank?

      Order.find_or_create_by!(user:, product:, created_at:, updated_at: created_at)
      count += 1
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback
    end
    log("Finished importing Orders #{count} / #{csv_data.size}")
  end

  private

  def csv_data
    @_csv_data = CSV.read(CSV_PATH)[1..]
  end

  def email_exists?(email:)
    User.where(email:).present?
  end

  def username_exists?(username:)
    User.where(username:).present?
  end
end
