import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import ProjectForm from './project_form';
import rootReducer from '../../../reducers/root_reducer';
import { createProject, updateProject, deleteProject, fetchProject } from '../../../actions/project_actions';
import { projectSelector } from  '../../../reducers/project_selectors';

const mapStateToProps = (state, ownProps) => {
  let project = {
    title: "",
    blurb: "",
    description: "",
    end_date: "",
    funding_goal: 0,
    total_amount: 0,
    image_url: "",
    user_id: "",
    author: "",
    form: 1
  };

  let formType = "new";
  if(ownProps.match.path.includes('edit')) {
    project = state.entities.projects[ownProps.match.params.projectId];
    formType = "edit"
  }

  return {
    user: state.session.currentUser,
    project,
    formType
  }
};

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchProject: id => dispatch(fetchProject(id)),
    createProject: project => dispatch(createProject(project)),
    updateProject: project => dispatch(updateProject(project)),
    deleteProject: projectId => dispatch(deleteProject(projectId))
  }
};


export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(ProjectForm));
