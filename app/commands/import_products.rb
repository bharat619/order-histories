# frozen_string_literal: true

class ImportProducts
  include Interactor
  include LogUtils

  CSV_PATH = Rails.root.join('data', 'products.csv')

  def call
    Rails.logger.info 'Importing products data'
    count = 0
    csv_data.each do |product|
      code, name, category_name = product
      next if code_exists?(code:)

      category = find_or_create_category(name: category_name)
      Product.find_or_create_by(code:, name:, category:)
      count += 1
    rescue ActiveRecord::RecordInvalid => e
      log("code: #{code}, name: #{name}, category: #{category}"\
                         "message: #{e.message}}")
      raise ActiveRecord::Rollback
    end
    log("Finished importing products: #{count} / #{csv_data.size}")
  end

  private

  def find_or_create_category(name:)
    Category.find_or_create_by(name:)
  end

  def csv_data
    @_csv_data = CSV.read(CSV_PATH)[1..]
  end

  def code_exists?(code:)
    Product.where(code:).present?
  end

  def username_exists?(username:)
    User.where(username:).present?
  end
end
