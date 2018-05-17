module Pardot
  module Objects
    module CustomFields
      def custom_fields
        @custom_fields ||= CustomFields.new self
      end

      class CustomFields

        def initialize(client)
          @client = client
        end

        def query(search_criteria)
          result = get '/do/query', search_criteria, 'result'
          result['total_results'] = result['total_results'].to_i if
            result['total_results']
          result
        end

        def create(params={})
          post('/do/create', params)
        end

        def read_by_id(id, params={})
          get("do/read/id/#{Pardot::Escape.escape id}", params)
        end

        def update_by_id(id, params={})
          post("do/update/id/#{Pardot::Escape.escape id}", params)
        end

        private

        def get(path, params={}, result='customField')
          response = @client.get('customField', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='customField')
          response = @client.post('customField', path, params)
          result ? response[result] : response
        end
      end
    end
  end
end
