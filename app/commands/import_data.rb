# frozen_string_literal: true

class ImportData
  include Interactor

  def call
    ActiveRecord::Base.transaction(joinable: false, requires_new: true) do
      ImportUsers.call
      ImportProducts.call
      ImportOrders.call
    end
  end
end
