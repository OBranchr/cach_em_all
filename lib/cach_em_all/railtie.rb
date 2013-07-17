module CachEmAll
  class Railtie < ::Rails::Railtie
    initializer 'cach_em_all' do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send     :include, CachEmAll::ActiveRecordBaseExt
        ActiveRecord::Relation.send :include, CachEmAll::ActiveRecordRelationExt
      end
    end
  end
end