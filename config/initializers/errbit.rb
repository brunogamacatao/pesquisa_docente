Airbrake.configure do |config|
  config.api_key = '041f19ba4f484d34ceea2ec307b4ac4b'
  config.host    = 'bcatao-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end