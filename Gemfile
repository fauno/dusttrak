source "https://rubygems.org"

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'haml'
gem 'activerecord', require: 'active_record'
gem 'mysql2'
gem 'bcrypt-ruby', require: 'bcrypt'

# Test requirements
group :test do
  gem 'minitest', require: 'minitest/autorun'
  gem 'rack-test', require: 'rack/test'
end

# Padrino Stable Gem
gem 'padrino', '0.11.3'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.3'
# end

# Debug
gem 'pry-padrino'

# Paginacion
gem 'will_paginate'
gem 'will_paginate-bootstrap'

# Exportar a XLS
gem 'writeexcel'
