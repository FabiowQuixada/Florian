shared_examples 'destroy tests' do
  let(:error_msg) { { message: I18n.t('errors.deletion'), success: false }.to_json }
  let(:non_admin_msg) { { message: I18n.t('errors.unpermitted_action'), success: false }.to_json }

  describe 'successfully deletes model as admin' do
    before :each do
      sign_in User.first
    end

    it 'via ajax' do
      count = model_class.count
      obj = model_class.first
      xhr :delete, :destroy, id: obj.id
      expect(model_class.count).to eq count - 1
      expect(response.body).to eq sucess_msg(obj.id)
    end

    it 'common request' do
      count = model_class.count
      obj = model_class.first
      xhr :delete, :destroy, id: obj.id
      expect(model_class.count).to eq count - 1
      expect(response.body).to eq sucess_msg(obj.id)
    end
  end

  describe 'does not destroy model as common user' do
    before :each do
      sign_in User.last
    end

    it 'via ajax' do
      count = model_class.count
      xhr :delete, :destroy, id: model_class.first.id
      expect(model_class.count).to eq count
      expect(response.body).to eq(non_admin_msg)
    end

    it 'common request' do
      count = model_class.count
      xhr :delete, :destroy, id: model_class.first.id
      expect(model_class.count).to eq count
      expect(response.body).to eq(non_admin_msg)
    end
  end

  #################################################################################################

  def sucess_msg(id)
    { message: model_class.new.was('destroyed'), model_id: id, success: true }.to_json
  end
end
