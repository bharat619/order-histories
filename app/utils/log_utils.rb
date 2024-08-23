# frozen_string_literal: true

module LogUtils
  def log(message = '', level = :info)
    @logger = Logger.new(STDOUT)
    @logger.public_send(level, message)
  end
end
