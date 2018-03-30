require "shapeshiftio/version"
require 'net/http'
require 'json'
module Shapeshiftio

private
  def self.api_call(params,url_method)
    url = URI.parse("https://shapeshift.io/#{url_method}")
    req = Net::HTTP::Post.new(url.request_uri)
    
    req.set_form_data(params)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    response = http.request(req)
    result = response.body.to_hash
  end


public
  def self.get(path_name, value = nil, p2 = nil)
    uri = URI("https://shapeshift.io/#{path_name}/#{value}/#{p2}")
    response = Net::HTTP.get(uri)
    check_response(response)
  end

  def self.get_coins
    coins = get("getcoins")
    all_coins = []
    coins.each do |coin|
      all_coins << coin[1]['name']
    end
    all_coins
  end

  def self.limit(coin_pair)
     get("limit", coin_pair)
  end
  
  def self.market_info(coin_pair)
     get("marketinfo", coin_pair)
  end
  
  def self.rate(coin_pair)
     get("rate", coin_pair)
  end
  
  def self.recent_tx(max)
    get("recenttx", max)
  end
  
  def self.tx_stat(deposit_address)
     get("txStat", deposit_address)
  end
  
  def self.time_remaining(deposit_address)
     get("timeremaining", deposit_address)
  end
  
  def self.validate(address,coin_symbol)
    get("validateAddress",address,coin_symbol)
  end

  def self.shift(withdrawal, coin_pair, options = {})
    params = {"withdrawal" => "#{withdrawal}",
      "pair" => "#{coin_pair}",
      "apiKey" => "c354645558d70364fbc6a6dc85679e602036cbabeb42c91b3e268e817dd3494c7a1304cd08e2499dfebd8b8d34c219a514ec66d5d013c190e4b82ea2d6f42437"
    }.merge!(options)
    
    api_call(params,"shift")
  end

  def self.receipt(email, txid)
    params = { "email" => "#{email}", "txid" => "#{txid}"}
    
    api_call(params,"mail")
  end

  def self.fixed(amount, wallet_address, coin_pair, options = {})
    
    params = {
      "amount" => "#{amount}",
      "withdrawal" => "#{wallet_address}",
      "pair" => "#{coin_pair}",
      "apiKey" => "c354645558d70364fbc6a6dc85679e602036cbabeb42c91b3e268e817dd3494c7a1304cd08e2499dfebd8b8d34c219a514ec66d5d013c190e4b82ea2d6f42437"
    }.merge!(options)
    api_call(params,"sendamount")
  end

  def self.quote(amount, coin_pair)
    
    params = { "amount" => "#{amount}", "pair" => "#{coin_pair}"}
    api_call(params,"sendamount")
  end

  def self.cancel(deposit_address)
    params= { "address" => "#{deposit_address}"}
    api_call(params,"cancelpending")
  end

  private

  def self.check_response(response)
    begin
      value = JSON.parse(response)
    rescue JSON::ParserError
      return puts "The API is not responding"
    end
  end

end
