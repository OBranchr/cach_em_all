module CachEmAll
  module ActiveRecordBaseExtension
    extend ActiveSupport::Concern
    included do
      def self.cache_key
        count          = self.count
        max_updated_at = self.maximum(:updated_at).try(:utc).try(:to_s, :number)
        name = self.name.tableize.pluralize
        "#{name}/all-#{count}-#{max_updated_at}"
      end
    end
  end
end