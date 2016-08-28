shared_examples 'an index view' do
  describe 'when list is not empty' do
    let(:model) { class_name.new }

    before :each do
      assign :model, model
      assign :list, class_name.all
      render
    end

    # Partials
    it { expect(view).to render_template(partial: 'shared/index_commons', locals: { model: model }) }

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
      assign :list, []
      render
    end

    # Partials
    it { expect(view).to render_template(partial: 'shared/index_commons', locals: { model: model }) }

    # Others
    it { expect(rendered).to include genderize_tag(model, 'helpers.none_registered') }
    it { expect(rendered).to include 'class="table table-striped table-hover table-bordered table-condensed tablesorter tablesorter-blue"' }
    it { expect(rendered).not_to include '<tr id=\'model_' }
    it { expect(rendered).not_to include '<td class="model_id admin-only" style="display: none;">' }
    it { expect(rendered).to include '<thead>' }
    it { expect(rendered).to include '<tbody>' }
  end
end
