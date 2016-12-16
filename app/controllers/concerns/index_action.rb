module IndexAction extend ActiveSupport::Concern

                   include HelperMethods

                   def index
                     @filter = model_class.new
                     @list = index_query

                     flash.now[:info] = t 'alert.query_results', count: @list.total_count if params[:q]
                   end

  private

                   def index_query
                   end

                   included do
                     before_action :before_index, only: [:index]
                   end

                   def before_index
                     @model = model_class.new
                     @breadcrumbs = breadcrumbs
                   end

end
