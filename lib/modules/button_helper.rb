module ButtonHelper

  def profile_btn
    link_to current_user.name, edit_user_registration_path
  end

  def logout_btn
    link_to t('helpers.action.logout'), destroy_user_session_path, method: :delete, style: 'margin-left: 5px;', class: 'btn btn-primary btn-xs'
  end

  def new_btn
    path = send "new_#{@model.class.to_s.underscore}_path", @model
    link_to genderize_full_tag(@model, 'helpers.action.new'), path, class: 'btn btn-primary'
  end

  def save_update_btn(_model, form)
    button_text = (@model.persisted? ? t('helpers.action.update') : t('helpers.action.save'))
    form.submit button_text, class: 'btn btn-primary save_btn'
  end

  def edit_btn(iterator)
    edit_path = send("edit_#{iterator.class.to_s.underscore}_path", iterator)
    link_to image_tag('edit.png', title: t('helpers.action.edit')), edit_path
  end

  def status_btn(iterator)
    if iterator.active
      deactivation_btn iterator
    else
      activation_btn iterator
    end
  end

  def user_help_btn(btn_id)
    image_tag('question_mark.png', title: t('user_help_messages.click_for_help'), id: btn_id, class: 'question_btn')
  end

  def form_back_btn
    content_tag :a, t('helpers.action.back'), id: 'form_back_btn', class: 'btn btn-primary back_btn'
  end

  def destroy_btn
    image_tag('destroy.png', title: t('helpers.action.destroy'), class: 'destroy_btn')
  end

  def admin_info_btn
    link_to image_tag('key.png', title: t('helpers.action.show_admin_private_data')), 'javascript:void(0)', class: 'admin_key_btn' if current_user.admin?
  end

  def author_email_btn
    link_to t('app_data.author'), 'javascript:void(0)', id: 'author_email_btn'
  end

  def sub_edit_btn(klass)
    image_tag 'edit.png', title: t('helpers.action.edit'), class: "edit_#{klass.to_s.underscore}_btn edit_btn"
  end

  def sub_destroy_btn(klass)
    link_to image_tag('delete.png', title: t('helpers.action.remove')), 'javascript:void(0)', class: "remove_#{klass.to_s.underscore}_btn remove_btn"
  end

  private ############################################################################################

  def deactivation_btn(iterator)
    path = send("deactivate_#{iterator.class.to_s.underscore}_path", iterator)
    link_to deactivate_img(iterator), path, method: :post, remote: true, id: "change_status_#{iterator.id}", 'data-type' => :json, class: 'deactivate_btn'
  end

  def activation_btn(iterator)
    path = send("activate_#{iterator.class.to_s.underscore}_path", iterator)
    link_to activate_img(iterator), path, method: :post, remote: true, id: "change_status_#{iterator.id}", 'data-type' => :json, class: 'activate_btn'
  end

  def app_about_btn
    link_to image_tag('info.png', title: t('helpers.about.title')), 'javascript:void(0)', id: 'app_about_btn'
  end
end
