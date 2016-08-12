module MainConcern extend ActiveSupport::Concern

                   module ClassMethods
                     attr_reader :arguable_opts

                     private

                     def arguable(opts = {})
                       @arguable_opts = opts
                     end

                     # rubocop:disable all
                     def get_arguable_opts
                       return self.class.superclass.arguable_opts if parent_class_args_only?
                       return self.class.superclass.arguable_opts.merge(self.class.arguable_opts) if parent_and_self_args?
                       self.class.arguable_opts
                     end
                     # rubocop:enable all

                     def parent_class_args_only?
                       self.class.arguable_opts.blank? && self.class.superclass.arguable_opts.present?
                     end

                     def parent_and_self_args?
                       self.class.arguable_opts.present? && self.class.superclass.arguable_opts.present?
                     end

                   end

                   def index

                     @list = index_sorting_method

                     @list = model_class.order order_attribute unless @list
                   end

                   def new
                     render '_form'
                   end

                   def create
                     @model = model_class.new send(@model.model_name.singular + '_params')

                     if @model.save
                       redirect_to send(@model.model_name.route_key + '_path'), notice: @model.was('created')
                     else
                       render '_form'
                     end
                   end

                   def edit
                     render '_form'
                   end

                   def show
                     render '_form'
                   end

                   def update
                     if @model.update send(@model.model_name.singular + '_params')
                       redirect_to send(@model.model_name.route_key + '_path'), notice: @model.was('updated')
                     else
                       render '_form'
                     end
                   end

                   def destroy
                     destroy_model

                     redirect_to send(@model.model_name.route_key + '_path'), notice: @model.was('destroyed') unless request.xhr?
                   end

  private

                   def destroy_model
                     if @model.destroy
                       render json: { message: @model.was('destroyed'), success: true }
                     else
                       render json: { message: @model.errors.full_messages[0], success: false }
                     end
                   end

                   def model_class
                     self.class.arguable_opts[:model_class]
                   end

                   included do
                     before_action :before_new, only: [:new, :create]
                     before_action :before_edit, only: [:edit, :update]
                     before_action :before_show, only: [:show]
                     before_action :before_index, only: [:index]
                     before_action :before_destroy, only: [:destroy]
                     before_action :authenticate_user!
                   end

                   def before_index
                     @model = model_class.new
                     @breadcrumbs = @model.breadcrumb_path
                   end

                   def before_new
                     @model = model_class.new
                     @breadcrumbs = @model.breadcrumb_path.merge Hash[t(@model.genderize('helpers.action.new')) => '']
                   end

                   def before_edit
                     @model = model_class.find(params[:id])
                     @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.edit') => '']

                     @breadcrumbs = @breadcrumbs.merge @model.breadcrumb_suffix unless @model.breadcrumb_suffix.nil?
                   end

                   def before_show
                     @model = model_class.find(params[:id])
                     @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.show') => '']
                   end

                   def before_destroy
                     return render json: { message: t('errors.undestroyable_user'), success: false } if model_class == User

                     return unless can_destroy?

                     @model = model_class.find(params[:id])
                     @breadcrumbs = @model.breadcrumb_path

                   end

                   def can_destroy?
                     unless current_user.admin?
                       if request.xhr?
                         render json: { message: t('errors.unpermitted_action'), success: false }
                       else
                         redirect_to send(@model.model_name.route_key + '_path'), alert: t('errors.unpermitted_action')
                       end
                     end

                     current_user.admin?
                   end

                   def order_attribute
                     'created_at ASC'
                   end

                   def index_sorting_method
                   end

end
