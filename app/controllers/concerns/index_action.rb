module IndexAction extend ActiveSupport::Concern

                   include HelperMethods

                   def index
                     @filter = model_class.new
                     @list = index_query
                     return if @list

                     @q = model_class.ransack(params[:q])
                     @list = @q.result.order('created_at ASC').page(params[:page])
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
