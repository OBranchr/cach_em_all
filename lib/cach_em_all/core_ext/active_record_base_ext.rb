module CachEmAll
  module ActiveRecordBaseExt
    extend ActiveSupport::Concern
    module ClassMethods
      def cache_key
        ar_count        = count
        max_updated_at  = maximum(:updated_at).try(:utc).try :to_s, :number
        name            = self.name.tableize
        prefix          = 'all'
        [name, [prefix, ar_count, max_updated_at].join('-')].join '/'
      end
    end
  end
end