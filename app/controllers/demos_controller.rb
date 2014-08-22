require 'Client'

class DemosController < ApplicationController
  def index
    redirect_to "http://beta.snowshoestamp.com/applications/client/4a950d6f134d084c12d6/"
  end

  def signup
  end

  def callback
    client = Client.new('4a950d6f134d084c12d6', '5712e47771f89930335b8068c9725f024c2a8aaa')

    @callback_url = "http://stampmaker2.herokuapp.com/stamp_info"
    @data = {"data" => params["data"], "new" => params["new"]}


    @consumer = OAuth::Consumer.new(
      client.app_key, 
      client.app_secret, 
      {:site => "http://beta.snowshoestamp.com/api",
      :scheme => :header
      })
    # Get Auth key with consumer
    @resp = @consumer.request(:post, '/v2/stamp', nil, {}, @data, { 'Content-Type' => 'application/x-www-form-urlencoded' })

    @response = JSON.parse(@resp.body)
    
    if @response.include? 'stamp' 
      redirect_to "http://snow.sh/coffee"
    else
      render action: "error"
    end
  end

  def error
  end

end
