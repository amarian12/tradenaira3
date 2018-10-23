import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import PledgeForm from './pledge_form';
import { fetchProject, createPledge } from '../../../actions/pledge_actions';
import { rewardsByProject } from '../../../reducers/reward_selector';
import { updateProject } from '../../../actions/project_actions';

const mapStateToProps = (state, ownProps) => {
  // console.log("pledge form state", state);
  let amount = {
    amount_pledged: 0,
    percentage: 0,
    project_id: ""
  }

  return {
    amount,
    user: state.session.currentUser,
    projects: state.entities.projects,
    rewards: state.entities.rewards,
    project: state.entities.projects[ownProps.match.params.projectId],
    filteredRewards: rewardsByProject(state.entities.rewards, ownProps.match.params.projectId)
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  const showId = ownProps.match.params.projectId
  return {
    createPledge: (pledge)=> dispatch(createPledge(pledge)),
    updateProject: (project)=> dispatch(updateProject(project)),
    fetchProject: () => dispatch(fetchProject(showId))
  }
}

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(PledgeForm))
