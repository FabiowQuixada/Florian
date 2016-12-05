module CreationActions extend ActiveSupport::Concern

                       include HelperMethods

                       def new
                         render '_form'
                       end

                       def create
                         @model = model_class.new model_params

                         if @model.save
                           redirect_to model_index_path, notice: @model.was('created')
                         else
                           render '_form'
                         end
                       end

  private

                       included do
                         before_action :before_creation, only: [:new, :create]
                       end

                       def before_creation
                         @model = model_class.new
                         @breadcrumbs = breadcrumbs.merge Hash[t(@model.genderize('helpers.action.new')) => '']
                       end

end
