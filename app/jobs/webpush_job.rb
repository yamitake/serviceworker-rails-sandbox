class WebpushJob < ActiveJob::Base
  queue_as :default

  def perform(message, params)
    client = WebpushClient.new

    log('---------------------------------------------------------------------------------')
    log("sending #{message} to #{params[:endpoint]}")
    response = client.send_notification(message, params)
    log(response ? "success" : "failed")
    log('---------------------------------------------------------------------------------')
    log(response.body.inspect)
  end

  def log(message)
    Rails.logger.info("[WebpushClient] #{message}")
  end
end
