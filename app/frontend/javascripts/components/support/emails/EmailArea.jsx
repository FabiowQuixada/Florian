import React from 'react';
import I18n from './../../../i18n'
import Email from './Email'
import { EDIT_FIELD, CLEAN_ERRORS } from './../../../constants/generalConstants';
import { add, remove } from './../../../actions/emailsActionCreators';
import { LOAD_LIST_FROM_SERVER } from './../../../constants/emailsConstants';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

const EmailArea = ({ data = [],
        msg_box_id = 'global',
        model,
        field_name = 'recipients_array',
        method_name = 'recipients_as_array',
        label,
        errors
      }, { store }) => {
  
  let table_rows = new Array();
  const state = store.getState();

  // TODO: This is a quick-fix due to an issue
  // with the communication between React and
  // Rails. Yeah, I know, this is *really* ugly;
  if(email_first_time[field_name]) {
    store.dispatch({
      type: LOAD_LIST_FROM_SERVER,
      model,
      field_name,
      rows: emailList[field_name]
    });
    email_first_time[field_name] = false;
  }

  for (let email of state.rows) {
    table_rows.push(
      <Email
        field_name={field_name}
        email={email} 
        key={`${field_name}_${email.address}`}
        onDestroy={ email => store.dispatch(remove(email)) } />
    );
  }

  return (
    <div>
      <div className="form-group">
        <label className="required" htmlFor={`${field_name}_new_recipient_field`}>
          {I18n.t(`activerecord.attributes.${model}.${field_name}`)}
        </label>

        <div className="input-group">
            <span className="input-group-addon">@</span>
            <input 
              type="text" 
              id={`${field_name}_new_recipient_field`} 
              className="form-control"
              value={state.email_field}
              onChange={field => {
                store.dispatch({
                  type: EDIT_FIELD,
                  value: field.target.value
                })}
              }
              placeholder={I18n.t('helpers.receipt_email.new_recipient')} />
            <span className="input-group-addon">
              <span 
                onClick={ () => store.dispatch(add(state.email_field)) } 
                id={`${field_name}_add_recipient_btn`}
                className="glyphicon glyphicon-plus add_recipient_btn" />
            </span>
        </div>
      </div>

      <table id={`${field_name}_recipients_table`} className="table table-striped table-condensed table-bordered unbreakable-table">
        <tbody>
          {table_rows}
        </tbody>
      </table>

      <input 
        type="hidden" 
        id={`${model}_${field_name}`} 
        name={`${model}[${field_name}]`} 
        value={store.getState().rows.toString()} />
    </div>
  );
}

EmailArea.contextTypes = {
  store: React.PropTypes.object
};

EmailArea.propTypes = {
  data: PropTypes.arrayOf(PropTypes.shape({
    is_persisted: PropTypes.string,
    address: PropTypes.string
  })),
  msg_box_id: PropTypes.string,
  model: PropTypes.string.isRequired,
  field_name: PropTypes.string,
  method_name: PropTypes.string,
  label: PropTypes.string,
  errors: PropTypes.arrayOf(PropTypes.string)
}

const mapStateToProps = state => ({ state: state });

export default connect(mapStateToProps, null)(EmailArea);
