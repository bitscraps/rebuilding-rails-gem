require "rack/test"

RSpec.describe Rulers do
  include Rack::Test::Methods

  let(:app) { Rulers::Application.new }

  it 'returns a request' do
    get "/"

    expect(last_response.ok?).to eq true
  end

    it 'returns a body' do
    get "/"

    expect(last_response.body).to eq 'Hello from Ruby on Rulers!'
  end

  it "has a version number" do
    expect(Rulers::VERSION).not_to be nil
  end
end
