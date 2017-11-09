class PostalCodesController < ApplicationController
  def show
    client = HTTPClient.new
    response = client.get('http://zipcloud.ibsnet.co.jp/api/search', 'zipcode' => params[:code])
    render :json => JSON.parse(response.body)
  end
end
