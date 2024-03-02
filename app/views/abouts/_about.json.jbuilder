json.extract! about, :id, :story, :blog_id, :created_at, :updated_at
json.url about_url(about, format: :json)
json.story about.story.to_s
