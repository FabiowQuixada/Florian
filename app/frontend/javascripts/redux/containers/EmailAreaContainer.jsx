import { connect } from 'react-redux';
import EmailArea from '../components/support/emails/EmailArea';
import * as actions from '../actions/emailsActionCreators';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = state => ({ name: state.name });

// Note that the component is not exported, only the redux "connected" version of it
export default connect(mapStateToProps, actions)(EmailArea);
