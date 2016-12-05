module DestroyAction extend ActiveSupport::Concern

                     include HelperMethods

                     def destroy
                       destroy_model
                       redirect_to model_index_path, notice: @model.was('destroyed') unless request.xhr?
                     end

  private

                     def destroy_model
                       return root_path, alert: t('errors.unpermitted_action'), status: :unauthorized if Rails.env.showcase?

                       if @model.destroy
                         render json: { message: @model.was('destroyed'), success: true }
                       else
                         render json: { message: @model.errors.full_messages[0], success: false }
                       end
                     end

                     def can_destroy?
                       unless current_user.admin?
                         if request.xhr?
                           render json: { message: t('errors.unpermitted_action'), success: false }
                         else
                           render 'index', alert: t('errors.unpermitted_action'), status: :unauthorized
                         end
                       end

                       current_user.admin?
                     end

                     included do
                       before_action :before_destruction, only: [:destroy]
                     end

                     def before_destruction
                       return render json: { message: t('errors.undestroyable_user'), success: false }, status: :unprocessable_entity if model_class == User
                       return unless can_destroy?

                       @model = model_class.find(params[:id])
                       @breadcrumbs = breadcrumbs
                     end
end
