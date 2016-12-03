shared_examples 'an index view' do
  describe 'when list is not empty' do
    let(:model) { class_name.new }

    before :each do
      q = class_name.ransack(params[:q])

      assign :model, model
      assign :q, q
      assign :list, q.result.page(params[:page])
      render
    end

    # Partials
    it { expect(view).to render_template('shared/_index_commons') }

    # Others
    it { expect(rendered).to include 'class="table table-striped table-hover table-bordered table-condensed tablesorter tablesorter-blue"' }
    it { expect(rendered).to include '<tr id="model_' }
    it { expect(rendered).to include '<td class="model_id admin-only">' }
    it { expect(rendered).to include '<thead>' }
    it { expect(rendered).to include '<tbody>' }
  end

  describe 'when list is empty' do
    let(:model) { class_name.new }

    before :each do
      assign :model, model
      assign :q, class_name.ransack(params[:q])
      assign :list, Kaminari.paginate_array([]).page(1)
      render
    end

    # Partials
    it { expect(view).to render_template('shared/_index_commons') }

    # Others
    it { expect(rendered).to include genderize_tag(model, 'model_phrases.none_registered') }
    it { expect(rendered).to include 'class="table table-striped table-hover table-bordered table-condensed tablesorter tablesorter-blue"' }
    it { expect(rendered).not_to include '<tr id=\'model_' }
    it { expect(rendered).not_to include '<td class="model_id admin-only" style="display: none;">' }
    it { expect(rendered).to include '<thead>' }
    it { expect(rendered).to include '<tbody>' }
  end
end
