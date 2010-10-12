module HandlerHelper
  module Ext

    def async_handler_map
      {
        Rack::Client::Handler::EmHttp   => EmHttpHelper::Async,
        Rack::Client::Handler::NetHTTP  => NetHTTPHelper::Async,
        Rack::Client::Handler::Typhoeus => TyphoeusHelper::Async,
      }
    end

    def sync_handler_map
      {
        Rack::Client::Handler::NetHTTP  => NetHTTPHelper::Sync,
        Rack::Client::Handler::Typhoeus => TyphoeusHelper::Sync
      }
    end

    def async_handler_context(handler, *middlewares, &block)
      context "Asynchronous" do
        include AsyncHelper
        include async_handler_map[handler]


        subject { build_subject(*middlewares) }

        around do |group|
          run_around(group) if respond_to?(:run_around)
        end

        instance_eval(&block)
      end
    end

    def sync_handler_context(handler, *middlewares, &block)
      context "Synchronous" do
        include SyncHelper
        include sync_handler_map[handler]

        subject { build_subject(*middlewares) }

        instance_eval(&block)
      end
    end

    def handler_contexts(*middlewares, &block)
      async_handler_contexts(*middlewares, &block)
      sync_handler_contexts(*middlewares, &block)
    end

    def async_handler_contexts(*middlewares, &block)
      async_handler_map.keys.each do |handler|
        async_handler_context(handler, *middlewares, &block)
      end
    end

    def sync_handler_contexts(*middlewares, &block)
      sync_handler_map.keys.each do |handler|
        sync_handler_context(handler, *middlewares, &block)
      end
    end
  end

  def self.included(context)
    context.extend Ext
  end
end
