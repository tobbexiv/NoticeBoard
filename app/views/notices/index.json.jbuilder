json.array!(@notices) do |notice|
  json.extract! notice, :id, :creator_id, :title, :category_id, :text
  json.url notice_url(notice, format: :json)
end
