module IndexAction extend ActiveSupport::Concern

                   include HelperMethods

                   def index
                     @list = index_sorting_method
                     @list = model_class.order order_attribute unless @list
                   end

  private

                   def order_attribute
                     'created_at ASC'
                   end

                   def index_sorting_method
                   end

                   included do
                     before_action :before_index, only: [:index]
                   end

                   def before_index
                     @model = model_class.new
                     @breadcrumbs = @model.breadcrumb_path
                   end

end
