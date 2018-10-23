import { connect } from 'react-redux';
import { login, logout, signup } from '../../actions/session_actions';
import SessionForm from './session_form';
import { receiveErrors, clearSessionErrors } from '../../actions/session_actions';
import rootReducer from '../../reducers/root_reducer';
import { withRouter } from 'react-router-dom';


const mapStateToProps = (state, ownProps) => {
  return {
    loggedIn: Boolean(state.session.currentUser),
    errors: state.errors.session,
  }
};

const mapDispatchToProps = (dispatch, { location }, ownProps) => {
  const formType = location.pathname.slice(1);
  const processForm = (formType === 'login') ? login : signup;
  return {
    processForm: user => dispatch(processForm(user)),
    formType,
    receiveErrors: (err) => dispatch(receiveErrors(err)),
    login: user => dispatch(login(user)),
    clearErrors: () => dispatch(clearSessionErrors())
  };
};

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(SessionForm));
