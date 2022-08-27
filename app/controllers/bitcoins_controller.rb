require 'net/http'
require 'json'

class BitcoinsController < ApplicationController
  def index
    @bitcoins = Bitcoin.all.order(created_at: :desc) 
  end

  def new
    @bitcoin = Bitcoin.new()
    @bitcoins = Bitcoin.all.order(created_at: :desc)
  end

  def create
    @bitcoin = Bitcoin.new(block_params)
    @bitcoins = Bitcoin.all.order(created_at: :desc) 
    # se instancia [:hash] pero aun no se guarda
    @bitcoin.block_hash = request_api(@bitcoin.block)
    # binding.pry
    if @bitcoin.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bitcoin = Bitcoin.find(params[:id])
  end

  def update
    @bitcoin = Bitcoin.find(params[:id])

    if @bitcoin.update(block_params)
      redirect_to @bitcoin
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def request_api(block)
    
    uri = URI("https://blockchain.info/rawblock/#{block}")
    res = Net::HTTP.get(uri)
    status = Net::HTTP.get_response(uri)
    if status.kind_of? Net::HTTPSuccess
      json = JSON.parse(res)
    end
    # when Net::HTTPUnauthorized
    #   {'error' => "#{res.message}: username and password set and correct?"}
    # when Net::HTTPServerError
    #   {'error' => "#{res.message}: try again later?"}
    # else
    #   {'error' => res.message}
  end

  def destroy
    @bitcoin = Bitcoin.find(params[:id])
    @bitcoin.destroy

    # respond_to do |format|
    #   format.turbo_stream {render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@bicoin)}_item")}
    # end
    redirect_to root_path, status: :see_other
  end
  private

  def block_params
    params.require(:bitcoin).permit(:block)
  end

end
