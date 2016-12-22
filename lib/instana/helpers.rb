module Instana
  module Helpers
    EUM_SNIPPET= (File.read(File.dirname(__FILE__) + '/eum/eum.js.erb')).freeze

    class << self

      # Returns a processed javascript snippet to be placed within the HEAD tag of an HTML page.
      #
      def eum_snippet(api_key, kvs = {})
        return nil if !::Instana.tracer.tracing?

        ::Instana.config[:eum_api_key] = api_key
        ::Instana.config[:eum_baggage] = kvs

        ERB.new(EUM_SNIPPET).result
      rescue => e
        Instana.logger.error "#{__method__}:#{File.basename(__FILE__)}:#{__LINE__}: #{e.message}"
        Instana.logger.debug e.backtrace.join("\r\n")
        return nil
      end
    end
  end
end
