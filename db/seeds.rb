Doorkeeper::Application.create(
  name: 'development',
  redirect_uri: 'http://localhost:4200',
  uid: ENV['OAUTH_CLIENT_ID'],
  secret: ENV['OAUTH_CLIENT_SECRET']
)
