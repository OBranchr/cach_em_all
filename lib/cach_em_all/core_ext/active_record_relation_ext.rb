module CachEmAll
  module ActiveRecordRelationExt
    extend ActiveSupport::Concern
    def cache_key
      ar_count        = count
      max_updated_at  = maximum(:updated_at).try(:utc).try :to_s, :number
      name            = self.name.tableize
      prefix          = Digest::SHA256.hexdigest to_sql.to_s
      [name, [prefix, ar_count, max_updated_at].join('-')].join '/'
    end
  end
end