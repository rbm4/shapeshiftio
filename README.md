# Shapeshiftio
A complete ruby wrapper for shapeshift.io API
[![Gem Version](https://badge.fury.io/rb/shapeshiftio.svg)](https://badge.fury.io/rb/shapeshiftio)<br>


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shapeshiftio', git: 'https://github.com/rbm4/shapeshiftio' 
or 
gem 'shapeshiftio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shapeshiftio

## Usage
* All methods return a JSON object with the fields detailed at the [shapeshift's official website](https://info.shapeshift.io/api)
* To call a method you only need the __required fields__, if you want to pass more parameters, just add a hash when callind a method (examples below)

# GET requests:

List available coins in the shapeshift API:

    Shapeshiftio.get_coins

Gets the current deposit limit set by Shapeshift for a specific pair:

    Shapeshiftio.limit("doge_dgb")

Market info of a specific pair:

    Shapeshiftio.market_info("doge_dgb")
    
Gets the current rate offered by Shapeshift:

    Shapeshiftio.rate("btc_eth")

Get a list of the most recent transactions:

    Shapeshiftio.recent_tx(max)  #[max] is an optional maximum number of transactions to return.

Returns the status of the most recent deposit transaction to the address:

    Shapeshiftio.tx_stat(deposit_address) #[address] is the deposit address to look up.

Time Remaining on Fixed Amount Transaction:

    Shapeshiftio.time_remaining(deposit_address) #[address] is the deposit address to look up. 

Validate an address, given a currency symbol and address.

    Shapeshiftio.validate(address,coin_symbol) #[address] the address that the user wishes to validate, [coinSymbol] the currency symbol of the coin

# POST requests

# Normal Transaction (convert coin):

withdrawal     = the address for resulting coin to be sent to<br>
pair       = what coins are being exchanged in the form [input coin]_[output coin]<br>
returnAddress  = (Optional) address to return deposit to if anything goes wrong with the exchange<br>
destTag    = (Optional) Destination tag that you want appended to a Ripple payment to you<br>
rsAddress  = (Optional) For new NXT accounts to be funded, you supply this on NXT payment to you<br>
apiKey     = (Optional) Your affiliate PUBLIC KEY<br>
 
example data: {"withdrawal":"AAAAAAAAAAAAA", "pair":"btc_ltc", returnAddress:"BBBBBBBBBBB"}<br>

    Shapeshiftio.shift("AAAAAAAAAAAAA","btc_ltc",options = {"returnAddress" : "BBBBBBBBBBB"})
    Shapeshiftio.shift("RIPPLE ADDRESS","ltc_xrp",options = {"returnAddres" : "RIPPLE ADDRESS", "destTag" : "RIPPLE ADDRESS TAG"})

# Request Email Receipt
email    = the address for receipt email to be sent to<br>
txid       = the transaction id of the transaction TO the user (ie the txid for the withdrawal NOT the deposit)<br>
example data {"email":"mail@example.com", "txid":"123ABC"}<br>

    Shapeshiftio.receipt("mail@example.com","123ABC")
    
# Fixed Amount Transaction / Quote Send Exact Price
amount          = the amount to be sent to the withdrawal address<br>
depositAmount   = the amount to be sent to the deposit address<br>
withdrawal      = the address for coin to be sent to<br>
pair                    = what coins are being exchanged in the form [input coin]_[output coin]  ie ltc_btc<br>
returnAddress   = (Optional) address to return deposit to if anything goes wrong with exchange<br>
destTag         = (Optional) Destination tag that you want appended to a Ripple payment to you<br>
rsAddress       = (Optional) For new NXT accounts to be funded, supply this on NXT payment to you<br>
apiKey          = (Optional) Your affiliate PUBLIC KEY, for volume tracking, affiliate payments, split-shifts, etc...<br>

    Shapeshiftio.fixed(amount, wallet_address, coin_pair, options = {})
    Shapeshiftio.quote(amount, coin_pair)

# Cancel Pending Transaction

    Shapeshiftio.cancel(deposit_address)

## Contributing

Bug reports and pull requests are welcome on GitHub.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
