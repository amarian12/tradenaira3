import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import CategoryIndex from './category_index';
import { fetchCategories, fetchCategory } from '../../../actions/category_actions';
import { fetchProject, fetchProjects } from '../../../actions/project_actions';

const mapStateToProps = (state, ownProps) => {


  return {
    categories: state.entities.categories,
    category: state.entities.categories[ownProps.match.params.categoryId],
    projects: state.entities.projects,
    project: state.entities.projects[ownProps.match.params.projectId]
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchCategories: () => dispatch(fetchCategories()),
    fetchCategory: (id) => dispatch(fetchCategory(id))
  }
}

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(CategoryIndex));
