import React from 'react';
import { is_empty } from './../../pages/support/message_area'
import { CLEAN_ERRORS } from './../../constants/generalConstants';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

const msg_as_html_ul = message => {
  let messages = [];

  for (let i = 0; i < message.length; i++)
    messages.push(<li key={i}>{message[i]}</li>);

  return <ul>{messages}</ul>;
}

const ErrorAlert = ({ msg_box_id = 'global', errors, onClose }) => {
  if(is_empty(errors)) {
    return null;
  }

  return (
    <div id={`${msg_box_id}_error_box`} className="alert alert-danger">
      <a href="javascript:void(0)" className="close" data-hide="alert" onClick={ () => onClose() }>&times;</a>
      <div id={`${msg_box_id}_error_messages`}>
        {msg_as_html_ul(errors)}
      </div>
    </div>
  );
}

ErrorAlert.propTypes = {
  msg_box_id: PropTypes.string,
  errors: PropTypes.arrayOf(PropTypes.string),
  onClose: PropTypes.func.isRequired
}

export default ErrorAlert;
