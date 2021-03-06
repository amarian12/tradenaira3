import { RECEIVE_REWARDS, RECEIVE_REWARD } from '../actions/reward_actions';
import merge from 'lodash/merge';


const rewardsReducer = (state = {}, action) => {
  Object.freeze(state);
  const newState = merge({}, state)
  switch(action.type){
    case RECEIVE_REWARDS:
      return action.rewards
    case RECEIVE_REWARD:
      newState[action.reward.project_id] = action.reward;
      return newState;
    default:
      return state;
  }
}

export default rewardsReducer;
