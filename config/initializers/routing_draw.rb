# FIXME: Remove this as it will exist by default on rails 6.1
# https://edgeguides.rubyonrails.org/routing.html#breaking-up-very-large-route-file-into-multiple-small-ones
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end
