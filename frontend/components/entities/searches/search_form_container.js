import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import { searchDatabase, deleteSearches } from '../../../actions/search_actions';
import SearchForm from './search_form';

const mapsStateToProps = (state, ownProps) => {
  return {
    user: state.session.currentUser,
    projects: state.entities.projects,
    searches: state.entities.searches
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    searchDatabase: (query) => dispatch(searchDatabase(query)),
    deleteSearches: (query) => dispatch(deleteSearches(query))
  }
}


export default withRouter(connect(
  mapsStateToProps,
  mapDispatchToProps
)(SearchForm));
