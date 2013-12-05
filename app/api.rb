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

  def new_id(arr)
    max_el = arr.max_by { |e| e['id'] }
    max_el['id'].succ || 1
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
      favourites: [ Db['favourites'] ],
      orders:     [ Db['orders'] ],
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
    attrs = params.merge('id' => new_id(Db['favourites']))
    Db['favourites'].push attrs
    success attrs
  end

  delete '/favourite/:id' do
    Db['favourites'].delete_if { |f| f['id'] == params[:id].to_i }
    success true
  end

  post '/orders' do
    attrs = params.merge('id' => new_id(Db['orders']))
    Db['orders'].push attrs
    success attrs
  end

  delete '/order/:id' do
    Db['orders'].delete_if { |o| o['id'] == params[:id].to_i }
    success true
  end

  get '/favourites' do
    success Db['favourites']
  end

  get '/orders' do
    success Db['orders']
  end
end
