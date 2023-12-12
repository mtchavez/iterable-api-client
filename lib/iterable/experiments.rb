# typed: true

module Iterable
  ##
  #
  # Interact with /experiments API endpoints
  #
  # @example Creating experiments endpoint object
  #   # With default config
  #   templates = Iterable::Experiments.new [1, 2, 3]
  #   templates.get
  #
  #   # With custom config
  #   conf = Iterable::Config.new(token: 'new-token')
  #   templates = Iterable::Experiments.new([1, 2, 3], config)
  class Experiments < ApiResource
    attr_reader :experiment_ids

    ##
    #
    # Initialize Experiments with an array of experiment ids
    #
    # @param experiment_ids [Array[Integer]] Array of experiment_id Integers
    # @param conf [Iterable::Config] A config to optionally pass for requests
    #
    # @return [Iterable::Experiments]
    sig do
      params(
        experiment_ids: T::Array[Integer],
        conf: T.nilable(Iterable::Config)
      ).void
    end
    def initialize(experiment_ids = [], conf = nil)
      @experiment_ids = experiment_ids
      super conf
    end

    ##
    #
    # Get metrics for experiments
    #
    # @param campaign_ids [Array] Array of campaignIds to optionally query for
    # @param start_time [Date|Time] Start of metrics to query for
    # @param end_time [Date|Time] End of metrics to query for
    #
    # @return [Iterable::Response] A response object
    sig do
      params(
        campaign_ids: Array,
        start_time: T.any(Date, Time, NilClass),
        end_time: T.any(Date, Time, NilClass)
      ).returns(Iterable::Response)
    end
    def metrics(campaign_ids = [], start_time = nil, end_time = nil)
      params = {
        experimentId: @experiment_ids,
        campaignId: campaign_ids
      }
      params[:startTime] = start_time.to_date.strftime(Iterable::DATE_FORMAT) if start_time
      params[:endTime] = end_time.to_date.strftime(Iterable::DATE_FORMAT) if end_time
      Iterable.request(conf, '/experiments/metrics', params).get
    end
  end
end
