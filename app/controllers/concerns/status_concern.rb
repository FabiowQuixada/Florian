module StatusConcern extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :arguable_opts

    private

    def arguable(opts={})
      @arguable_opts = opts
    end

    def get_arguable_opts
      if self.class.arguable_opts.blank? && self.class.superclass.arguable_opts.present?
        opts = self.class.superclass.arguable_opts
      elsif self.class.arguable_opts.present? && self.class.superclass.arguable_opts.present?
        opts = self.class.superclass.arguable_opts.merge(self.class.arguable_opts)
      else
        opts = self.class.arguable_opts
      end
      opts || {}
    end

  end

  def activate
    begin
      model = model_class.find params[:id]
      model.active = true
      model.save

      render :json => {:message => genderize_tag(model, 'activated'), :id => model.id, :activated => true}
    rescue => exc
      exception_message = handle_exception exc, exc.message
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  def deactivate
    begin

      model = model_class.find params[:id]
      model.active = false
      model.save

      render :json => {:message => genderize_tag(model, 'deactivated'), :id => model.id, :activated => false}
    rescue => exc
      exception_message = handle_exception exc, exc.message
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  private

  def model_class
    self.class.arguable_opts[:model_class]
  end

  included do
    before_action :authenticate_user!
  end

end