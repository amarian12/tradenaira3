import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import ProjectShow from './project_show';
import rootReducer from '../../../reducers/root_reducer';
import { fetchProject, updateProject, deleteProject, fetchProjects } from '../../../actions/project_actions';
import { fetchRewards } from '../../../actions/reward_actions';
import { rewardsByProject } from '../../../reducers/reward_selector';
import { fetchCategories, fetchCategory } from '../../../actions/category_actions';


const mapStateToProps = (state, ownProps) => {
  return {
    user: state.session.currentUser,
    project: state.entities.projects[ownProps.match.params.projectId],
    projects: state.entities.projects,
    rewards: rewardsByProject(state.entities.rewards, ownProps.match.params.projectId)
  }
};

const mapDispatchToProps = (dispatch, ownProps) => {
  const showId = ownProps.match.params.projectId
  return {
    fetchProjects: () => dispatch(fetchProjects()),
    fetchProject: () => dispatch(fetchProject(showId)),
    fetchRewards: () => dispatch(fetchRewards()),
    deleteProject: (id) => dispatch(deleteProject(id)),
    fetchCategories: () => dispatch(fetchCategories()),
    fetchCategory: (id) => dispatch(fetchCategory(id)),
    updateProject: (project)=> dispatch(updateProject(project))
  }
};

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectShow));
