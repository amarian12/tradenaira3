import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import RewardForm from './reward_form';
import { createReward, updateReward, fetchRewards } from '../../../actions/reward_actions';

const mapStateToProps = (state, ownProps) => {
  let reward =  {
      title: "",
      amount_met: 0,
      description: "",
      project_id: 0
    };


  return {
    user: state.session.currentUser,
    reward,
    rewards: state.entities.rewards,
    project: state.entities.projects[ownProps.match.params.projectId]
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  const projectId = ownProps.match.params.projectId
  return {
    fetchRewards: () => dispatch(fetchRewards(projectId)),
    createReward: (reward) => dispatch(createReward(reward)),
    updateReward: (reward) => dispatch(updateReward(reward))
  }
};

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(RewardForm));
