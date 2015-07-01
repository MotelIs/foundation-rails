RSpec::Matchers.define :render_unauthorized do |expected|
  match do |actual|
    json = JSON.parse(response.body)
    actual.status == 401 && json && json['errors'] = "you are unauthorized"
  end

end
