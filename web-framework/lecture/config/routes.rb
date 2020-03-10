Simpler.application.routes do
  get '/', 'tests#index'
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'
end
