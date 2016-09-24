module ModificationActions extend ActiveSupport::Concern

                           include HelperMethods

                           def edit
                             render '_form'
                           end

                           def update
                             if @model.update model_params
                               redirect_to model_index_path, notice: @model.was('updated')
                             else
                               render '_form'
                             end
                           end

  private

                           included do
                             before_action :before_modification, only: [:edit, :update]
                           end

                           def before_modification
                             @model = model_class.find(params[:id])
                             @breadcrumbs = @model.breadcrumb_path.merge Hash[@model => '']
                           end
end
