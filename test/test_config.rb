PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path('../../config/boot', __FILE__)

class MiniTest::Spec
  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods

  # You can use this method to custom specify a Rack app
  # you want rack-test to invoke:
  #
  #   app Dusttrak::App
  #   app Dusttrak::App.tap { |a| }
  #   app(Dusttrak::App) do
  #     set :foo, :bar
  #   end
  #
  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

# Busca en test/factories automáticamente
FactoryGirl.find_definitions

# Mete cada test en una transacción (por eso los before y after)
DatabaseCleaner.strategy = :transaction
