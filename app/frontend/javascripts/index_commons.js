import I18n from './i18n'
import { on_action } from './application'
import { display_confirm_modal } from './others/modals'
import { display_notice, display_error, hide_all_messages, to_top, msg_as_html_ul } from './message_area'
import ServerFunctions from './server_functions'

$(() => { if(on_action('index')) new IndexCommons() });

class IndexCommons {
  constructor() {
    let any_field_filled = false;

    $("#index_filters input:not([type='submit']), #index_filters select").each((index, field) => {
      if (!$(field).val()) {
        any_field_filled = true;
        return;
      }
    });
    
    if(any_field_filled) {
      $('.panel-collapse').collapse({
        toggle: true
      });
    }

    $('.clean_filters_btn').on('click', () => {
      const model = $('#rails_model').val();
      window.location = ServerFunctions.paths.index(model);
    });

    $('.destroy_btn').on('click', e => {
      const id = $(e.currentTarget).closest('.model_row').find('.model_id').html();
      const model = $('#rails_model').val();
      const i18nModel = I18n.t(`activerecord.models.${model}.one`).toLowerCase();
      display_confirm_modal(I18n.t('modal.title.destroy'),
        I18n.t('model_phrases.are_you_sure.destroy.n.s', { model: i18nModel }), 
        IndexCommons.destroy_model.bind(self, id)
      );
    });
  }

  static destroy_model(id) {
    const controller = $('#rails_controller').val();
    
    $.ajax({
      type: "DELETE",
      url: `${ServerFunctions.paths.index(controller)}/${id}`,
      beforeSend: xhr => {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      dataType: "json",
      success: response => {
        const message = response.message;

        if(response.success) {
          display_notice(message);

          $(`#model_${response.model_id}`).remove();
          const model = $('#rails_model').val();

          if($('#index_table tbody tr').length === 1) {
            $(`tr.no_${model}_row`).removeClass('hidden');
          }
        } else {
          display_error(message);
        }
      },
      error: response => {
        display_error(I18n.t('error_pages.internal_server_error.title'));
      }
    });
  }
}

export default IndexCommons
