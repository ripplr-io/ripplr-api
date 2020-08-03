puts "Creating levels 🪜🪜🪜"

filename = Rails.root.join('db', 'seeds', 'resources', 'levels.json')
data = JSON.parse(File.read(filename))['data']

data.each do |seed_level|
  Level.find_or_create_by!(name: seed_level['name']) do |level|
    level.from = seed_level['from']
    level.to = seed_level['to']
    level.posts = seed_level['posts']
    level.referrals = seed_level['referrals']
    level.subscriptions = seed_level['subscriptions']
  end
end

