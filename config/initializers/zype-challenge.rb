# Gateways
require Rails.root.join('lib', 'zype', 'base')
Dir[Rails.root.join('lib', 'zype', '*.rb')].each { |f| require f }

# Errors
require Rails.root.join('lib', 'errors', 'bad_request')