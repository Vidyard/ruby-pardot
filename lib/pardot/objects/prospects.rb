module Pardot
  module Objects
    module Prospects
      def prospects
        @prospects ||= Prospects.new self
      end

      class Prospects

        def initialize client
          @client = client
        end

        def query search_criteria
          result = get "/do/query", search_criteria, "result"
          result["total_results"] = result["total_results"].to_i if result["total_results"]
          result
        end

        def assign_by_email email, params
          post "/do/assign/email/#{Pardot::Escape.escape email}", params
        end

        def assign_by_id id, params
          post "/do/assign/id/#{Pardot::Escape.escape id}", params
        end

        def assign_by_fid fid, params
          post "/do/assign/fid/#{Pardot::Escape.escape fid}", params
        end

        def create email, params = {}
          post "/do/create/email/#{Pardot::Escape.escape email}", params
        end

        def delete_by_id id, params = {}
          post "/do/delete/id/#{Pardot::Escape.escape id}", params
        end

        def delete_by_fid fid, params = {}
          post "/do/delete/fid/#{Pardot::Escape.escape fid}", params
        end

        def read_by_email email, params = {}
          post "/do/read/email/#{Pardot::Escape.escape email}", params
        end

        def read_by_id id, params = {}
          post "/do/read/id/#{Pardot::Escape.escape id}", params
        end

        def read_by_fid fid, params = {}
          post "/do/read/fid/#{Pardot::Escape.escape fid}", params
        end

        def unassign_by_email email, params = {}
          post "/do/unassign/email/#{Pardot::Escape.escape email}", params
        end

        def unassign_by_id id, params = {}
          post "/do/unassign/id/#{Pardot::Escape.escape id}", params
        end

        def unassign_by_fid fid, params = {}
          post "/do/unassign/fid/#{Pardot::Escape.escape fid}", params
        end

        def update_by_email email, params = {}
          post "/do/update/email/#{Pardot::Escape.escape email}", params
        end

        def update_by_id id, params = {}
          post "/do/update/id/#{Pardot::Escape.escape id}", params
        end

        def update_by_fid fid, params = {}
          post "/do/update/fid/#{Pardot::Escape.escape fid}", params
        end

        def upsert_by_email email, params = {}
          post "/do/upsert/email/#{Pardot::Escape.escape email}", params
        end

        def upsert_by_id id, params = {}
          post "/do/upsert/id/#{Pardot::Escape.escape id}", params
        end

        def upsert_by_fid fid, params = {}
          post "/do/upsert/fid/#{Pardot::Escape.escape fid}", params
        end

        protected

        def get path, params = {}, result = "prospect"
          response = @client.get "prospect", path, params
          result ? response[result] : response
        end

        def post path, params = {}, result = "prospect"
          response = @client.post "prospect", path, params
          result ? response[result] : response
        end

      end

    end
  end
end
