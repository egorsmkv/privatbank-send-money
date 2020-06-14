# frozen_string_literal: true

require 'cabin'
require 'optparse'
require 'logger'
require 'privatbank'
require 'privatbank/p24'

# Config
MERCHANT_ID = 'XXXXX'
MERCHANT_PASSWORD = 'YYYYYYYYYYYYYYYYYYYYYYYY'
LOG_PATH = __dir__ + '/send_money.log'

# Parse arguments
options = {}

optparser = OptionParser.new do |opts|
  opts.on('-p', '--payment_id PAYMENT_ID', String, 'Payment ID') do |value|
    options[:payment_id] = value
  end

  opts.on('-c', '--card CARD', String, 'Card of the receiver') do |value|
    options[:card] = value
  end

  opts.on('-a', '--amount AMOUNT', Float, 'Amount') do |value|
    options[:amount] = value
  end

  opts.on('-d', '--details DETAILS', String, 'Details') do |value|
    options[:details] = value
  end
end

# Check arguments and raise an error if something is wrong
begin
  optparser.parse!

  mandatory = %i[payment_id card amount details]
  missing = mandatory.select { |param| options[param].nil? }

  raise OptionParser::MissingArgument, missing.join(', ') unless missing.empty?
rescue OptionParser::ParseError => e
  puts e
  puts optparser
  exit 1
end

# Create our logger
logger = Cabin::Channel.new
logger.level = :info
logger.subscribe(Logger.new(LOG_PATH, 'daily'))

# Configure the PrivatBank library
Privatbank.configure do |config|
  config.merchant_id = MERCHANT_ID
  config.merchant_password = MERCHANT_PASSWORD
end

# Add some context
options[:merchant_id] = MERCHANT_ID
options[:merchant_password] = MERCHANT_PASSWORD

# Configure our variables
payment_id = options[:payment_id]
card = options[:card]
amount = options[:amount]
details = options[:details]

# Make the payment
response = Privatbank::P24.send_money_pb(card, payment_id, amount, details)

# Add result to options
options[:api_result] = response

# Log result
logger.info('Payment initialized', options)
