puts "Creating topics 🍹🍹🍹"

filename = Rails.root.join('db', 'seeds', 'resources', 'topics.json')
data = JSON.parse(File.read(filename))['data']

data.each do |seed_level|
  Topic.find_or_create_by!(name: seed_level['name']) do |level|
    level.description = seed_level['description']
    level.avatar = seed_level['avatar']
  end
end
