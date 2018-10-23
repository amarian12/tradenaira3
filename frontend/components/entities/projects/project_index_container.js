import { connect } from 'react-redux';
import ProjectIndex from './project_index';
import rootReducer from '../../../reducers/root_reducer';
import { fetchCategories, fetchCategory } from '../../../actions/category_actions';
import { fetchCategoryProjects, fetchProjects } from '../../../actions/project_actions';



const mapStateToProps = (state, ownProps) => {
  return {
    categoryId: ownProps.categoryId,
    projects: Object.values(state.entities.projects),
    categories: Object.values(state.entities.categories),
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchProjects: () => dispatch(fetchProjects()),
    fetchProject: (id) => dispatch(fetchProject(id)),
    createProject: (project) => dispatch(createProject(project)),
    updateProject: (project) => dispatch(updateProject(project)),
    deleteProject: (projectId) => dispatch(deleteProject(projectId)),
    fetchCategories: () => dispatch(fetchCategories()),
    fetchCategory: (id) => dispatch(fetchCategory(id)),
    fetchCategoryProjects: (categoryId) => dispatch(fetchCategoryProjects(categoryId))
  }
}


export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectIndex);
