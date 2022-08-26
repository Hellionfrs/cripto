class BitcoinsController < ApplicationController
  def index
    
  end

  def create
    @bitcoin = Bitcoin.new(block_params)
    # se instancia [:hash] pero aun no se guarda
    @bitcoin.hash = request_api(@bitcoin.block)
    if @bitcoin.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def search


  end

  def request_api(block)
    
    uri = URI('https://blockchain.info/rawblock/#{block}')
    res = Net::HTTP.get(uri)
    case res
    when Net::HTTPSuccess
      json = JSON.parse(res.body)
    # when Net::HTTPUnauthorized
    #   {'error' => "#{res.message}: username and password set and correct?"}
    # when Net::HTTPServerError
    #   {'error' => "#{res.message}: try again later?"}
    # else
    #   {'error' => res.message}
    end
    
  end
  private

  def block_params
    params.require(:bitcoin).permit(:block)
  end

end
