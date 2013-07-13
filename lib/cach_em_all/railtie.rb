module CachEmAll
  class Railtie < ::Rails::Railtie
    initializer 'cach_em_all' do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, CachEmAll::ActiveRecordBaseExtension
      end
    end
  end
end