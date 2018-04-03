require 'faraday'
require 'uri'
require_relative './../config/constants'

namespace :json do

  conn = Faraday.new(url: Constants::GIST_BASE_PATH)

  desc "Download coupon codes file"
  task :coupon_codes do
    puts Constants::COUPON_CODE_DOWNLOAD_MSG
    response = conn.get Constants::COUPON_CODES_REMOTE_PATH
    store_file(response, Constants::COUPON_CODES_STORE_PATH);
  end

end

private

  def store_file(response, file_store_path)
    File.open(file_store_path, "w+") { |file| file.write(response.body) }
  end
