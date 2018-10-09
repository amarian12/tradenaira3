json.array!(@blogo_banners) do |blogo_banner|
  json.extract! blogo_banner, :id, :title, :image, :category
  json.url blogo_banner_url(blogo_banner, format: :json)
end
