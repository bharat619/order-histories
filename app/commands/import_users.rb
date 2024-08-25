# frozen_string_literal: true

class ImportUsers
  include Interactor
  include LogUtils

  USER_CSV_PATH = Rails.root.join('data', 'users.csv')

  def call
    Rails.logger.info 'Importing user data'
    count = 0
    csv_data.each do |user|
      username, email, phone = user
      next if username_exists?(username:)
      next if email_exists?(email:)

      User.create!(username:, email:, phone:)
      count += 1
    rescue ActiveRecord::RecordInvalid => e
      log("Could not import user. username: #{username}, email: #{email}, phone: #{phone}"\
                         "message: #{e.message}}")
    end
    log("Finished importing #{count} / #{csv_data.size}")
  end

  private

  def csv_data
    @_csv_data = CSV.read(USER_CSV_PATH)[1..]
  end

  def email_exists?(email:)
    User.where(email:).present?
  end

  def username_exists?(username:)
    User.where(username:).present?
  end
end
