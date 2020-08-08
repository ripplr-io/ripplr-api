def load_seed(name)
  filename = Rails.root.join('db', 'seeds', "#{name.to_s}.rb")
  load filename
end

load_seed :levels
load_seed :topics
