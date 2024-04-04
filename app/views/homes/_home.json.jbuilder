json.extract! home, :id, :about, :blogs_id, :time_tag, :created_at, :updated_at
json.url home_url(home, format: :json)
json.about home.about.to_s
