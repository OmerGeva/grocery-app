json.array! @items do |item|
  json.item do
    json.name item[0]
    json.price item[1]
    json.description item[2]
    json.photo item[3]
  end
end
