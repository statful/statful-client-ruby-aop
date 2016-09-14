require 'aspector'

# Statful Aspects Instance
#
# @attr_reader statful_client [Object] Statful client
class StatfulAspects
  attr_reader :statful_client

  def new
    self
  end

  # Initialize the client
  #
  # @param [Object] statful Initialized Statful client
  # @return [Object] The Statful aspects
  def initialize(statful)
    raise ArgumentError.new('Statful client is missing') if statful.nil?

    @statful_client = statful
    self
  end

  # Sends a timer with the method execution time.
  #
  # @param clazz [Object] Class to apply the aspect
  # @param method [String] Name of the method to apply the aspect
  # @param name [String] Name of the timer
  # @param [Hash] options The options to apply to the metric
  # @option options [Hash] :tags Tags to associate to the metric
  # @option options [Array<String>] :agg List of aggregations to be applied by Statful
  # @option options [Integer] :agg_freq Aggregation frequency in seconds
  # @option options [String] :namespace Namespace of the metric
  def timer(clazz, method, name, options = {})
    statful_client = @statful_client

    aspector(clazz, { :method => method }) do
      before do
        @before = Time.now
      end

      after do |result|
        now = Time.now
        time = (now - @before) * 1000.0
        statful_client.timer(name, time.round(3), options)
        result
      end
    end
  end
end

