json.post do
  json.title @post.title
  json.latitude @post.latitude
  json.longitude @post.longitude
end