require 'uri'
require 'net/http'
require 'json'

require 'bundler'
Bundler.require




session = GoogleDrive::Session.from_service_account_key("client_secret.json")

def interval seconds
  loop do
    yield
    sleep seconds
  end
end

interval 5 do

  spreadsheet = session.spreadsheet_by_title("Talkpush exercice")
  worksheet = spreadsheet.worksheets.first
  client_rows = worksheet.rows.length
  puts client_rows

  spreadsheet2 = session.spreadsheet_by_title("Storage Talkpush exercice")
  worksheet2 = spreadsheet2.worksheets.first
  backend_rows = worksheet2.rows.length
  puts backend_rows

  array1 = []
  new_entries = worksheet.rows.last(1).each { |row| array1.push(row.last(5)) }

  if client_rows > backend_rows
    puts "new entry"
    new_first_name = array1[0][1]
    new_last_name = array1[0][2]
    new_email = array1[0][3]
    new_phone = array1[0][4].to_s
    puts new_first_name
    puts new_last_name
    puts new_email
    puts new_phone
    worksheet2.insert_rows(worksheet2.num_rows + 1, array1)
    worksheet2.save

    uri = URI.parse("https://my.talkpush.com/api/talkpush_services/campaigns/4339/campaign_invitations")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Cache-Control"] = "no-cache"
    request.body = JSON.dump({
      "api_key" => "abcde12345",
      "api_secret" => "abcde12345",
      "campaign_invitation" => {
        "first_name" => new_first_name,
        "last_name" => new_last_name,
        "email" => new_email,
        "user_phone_number" => new_phone
      }
    })
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    puts response.code
    puts response.body

  end

end