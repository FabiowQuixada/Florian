module MainConcern extend ActiveSupport::Concern

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

  def index
    @list = model_class.order order_attribute
  end

  def new
    render '_form'
  end

  def create
    @model = model_class.new params_validation

    if @model.save
      redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'created')
    else
      render '_form'
    end
  end

  def edit
    render '_form'
  end

  def update
    if @model.update params_validation
      redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'updated')
    else
      render '_form'
    end
  end

  private

  def model_class
    self.class.arguable_opts[:model_class]
  end

  included do
    before_action :before_new, only: [:new, :create]
    before_action :before_edit, only: [:edit, :update]
    before_action :before_index, only: [:index]
    before_action :authenticate_user!
  end

  def before_index
    @model = model_class.new

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => ""]
  end

  def before_new
    @model = model_class.new

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => send(@model.model_name.route_key + "_path"), t(@model.genderize('helpers.action.new')) => ""]
  end

  def before_edit
    @model = model_class.find(params[:id])

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => send(@model.model_name.route_key + "_path"), t('helpers.action.edit') => ""]
  end

  def order_attribute
    "created_at ASC"
  end
end