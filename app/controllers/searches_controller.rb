class SearchesController < ApplicationController
  def index
    search_value = params[:search] if params[:search]
    @response = if search_value
                  res = Faraday.get "https://api.github.com/search/repositories?q=name:#{search_value}&per_page=100"
                  items = JSON.parse(res.body)['items']
                  items.paginate(page: params[:page], per_page: 30)
                else
                  []
                end
  end
end
