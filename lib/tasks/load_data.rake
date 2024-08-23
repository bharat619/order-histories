# frozen_string_literal: true

namespace :application_data do
  desc 'Load the users, products and order details from the CSV in data folder'
  task load_data: :environment do
    PRODUCTS_CSV_PATH = Rails.root.join('data', 'products.csv')
    ORDER_DETAILS_CSV_PATH = Rails.root.join('order_details.csv')
    
    Rails.logger.info 'Importing data'

    command = ImportData.call

    if command.success?
      Rails.logger.info 'Finished importing data'
    end
  end
end
