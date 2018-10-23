import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import RewardIndex from './reward_index';
import { createReward, updateReward, fetchRewards } from '../../../actions/reward_actions';
import { rewardsByProject } from '../../../reducers/reward_selector';
import { updateProject } from '../../../actions/project_actions';

const mapStateToProps = (state, ownProps) => {
  // console.log("Rewards state:", state);
  // console.log("Rewards ownProps", ownProps);

  return {
    user: state.session.currentUser,
    project: ownProps.props.project,
    rewards: rewardsByProject(state.entities.rewards, ownProps.match.params.projectId)
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  // receiveReward: (id) => dispatch(receiveReward(id)),
  return {
    fetchRewards: (projectId) => dispatch(fetchRewards(projectId)),
    createReward: (reward) => dispatch(createReward(reward)),
    updateReward: (reward) => dispatch(updateReward(reward)),
    updateProject: (project) => dispatch(updateProject(project))
  }
};

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(RewardIndex));
