class Api < Sinatra::Base
  before do
    content_type 'application/json'
  end

  get '/' do
    { status: :success, data: 'ok' }.to_json
  end

  post '/session/sign_in' do
    carwashes = Db['carwashes']
    { status: :success,
      data: {
        profile:    {},
        session_id: '12345',
        nearby:     [carwashes[0], carwashes[1]],
        favourites: [carwashes[1], carwashes[2]],
        orders:     [{
          time_from:  carwashes[1][ 'time_periods' ][0][ 'time_from' ],
          time_to:    carwashes[1][ 'time_periods' ][0][ 'time_to' ],
          price:      carwashes[1][ 'time_periods' ][0][ 'price' ],
          carwash_id: carwashes[1][ 'id' ],
          carwash:    carwashes[1] }],
        history:    [],
        price_range: [200, 500]
      }
    }.to_json
  end

  post '/request/pin' do
    { status: :success, data: 'ok' }.to_json
  end

  put '/profile' do
    profile = Db['profile']
    #profile = 
    { status: :success, data: profile }.to_json
  end
end
