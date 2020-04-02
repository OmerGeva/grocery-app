json.array! @supermarkets do |supermarket|
  json.user do
    json.name supermarket.name
    json.photo supermarket.photo.service_url
  end
end
