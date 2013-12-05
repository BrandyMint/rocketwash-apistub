class Api < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  before do
    content_type 'application/json'
  end

  def success(data)
    { status: :success, data: data }.to_json
  end

  get '/' do
    success 'ok'
  end

  post '/session/sign_in' do
    carwashes = Db['carwashes']
    success(
      profile:    {},
      session_id: '12345',
      nearby:     [carwashes[0], carwashes[1]],
      favourites: [Db['favourites']],
      orders:     [{
        time_from:  carwashes[1][ 'time_periods' ][0][ 'time_from' ],
        time_to:    carwashes[1][ 'time_periods' ][0][ 'time_to' ],
        price:      carwashes[1][ 'time_periods' ][0][ 'price' ],
        carwash_id: carwashes[1][ 'id' ],
        carwash:    carwashes[1] }],
      history:    [],
      price_range: [200, 500] )
  end

  post '/request/pin' do
    success true
  end

  put '/profile' do
    profile = Db['profile'] = params
    success profile
  end

  get '/profile' do
    success Db['profile']
  end

  post '/favourites' do
    attrs = params.merge(id: Db['favourites'].length)
    Db['favourites'].push attrs
    success attrs
  end

  delete '/favourite/:id' do
    Db['favourites'].delete_at(params[:id].to_i)
    success true
  end

  get '/favourites' do
    success Db['favourites']
  end

  post '/orders' do
    attrs = params.merge(id: Db['orders'].length)
    Db['orders'].push attrs
    success attrs
  end

  delete '/order/:id' do
    Db['orders'].delete_at(params[:id].to_i)
    success true
  end

  get '/orders' do
    success Db['orders']
  end
end
