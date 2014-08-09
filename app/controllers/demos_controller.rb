require 'Client'
# include Client

class DemosController < ApplicationController
  def index
  	@demos = Demo.all
  end

  def new
  	@demo = Demo.new
  end

  def create
    @demo = Demo.new(demo_params)
      binding.pry
    if demo_params["asset_url"] = nil
      @demo.is_image = true
      if @demo.save
        redirect_to demos_path
      else
        flash[:notice] = "Did not save. Cannot create new stamps with the same stamp-serial."
        render action: "index"
      end
    else
      @demo.stamp_image = nil
      if @demo.save
        redirect_to demos_path
      else
        flash[:notice] = "Did not save. Cannot create new stamps with the same stamp-serial."
        render action: "index"
      end
    end
  end

  def update
    @demo = Demo.find_by_stamp_serial(params[:demo][:stamp_serial])
    if @demo.update(demo_params)
      redirect_to demos_path
    else
      render action: "edit"
    end
  end

  def callback
    client = Client.new('5bc9c3ddf1f46265e03a', '70a99aa7f4de7f48f235215ce2708b6e4f19377c')

    @callback_url = "10.99.114.195:3000/stamp_info"
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
    @form_filler = @response["stamp"]["serial"]

    if params["new"] 
      @demo = Demo.new
      render action: "new"
    elsif params["edit"]
      @demo = Demo.find_by_stamp_serial(@form_filler)
      render action: "edit"
    else
      @demo = Demo.find_by_stamp_serial(@form_filler)
      binding.pry
      if @demo.is_image
        render action: "callback"
      else
        redirect_to @demo.asset_url
      end
    end
  end

  def errors
    #TODO: send error
  end

  private

  def demo_params
  	params.require(:demo).permit(:stamp_serial, :stamp_image, :is_image, :asset_url)
  end 
end
