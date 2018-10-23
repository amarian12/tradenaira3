import * as APIUtil from '../util/reward_util'

export const RECEIVE_REWARD = "RECEIVE_REWARD";
export const RECEIVE_REWARDS = "RECEIVE_REWARDS";

export const receiveRewards = (rewards) => ({
  type: RECEIVE_REWARDS,
  rewards
});

export const receiveReward = (reward) => ({
  type: RECEIVE_REWARD,
  reward
});

export const fetchRewards = (projectId) => (dispatch) => (
  APIUtil.fetchRewards(projectId).then((reward)=> dispatch(receiveRewards(reward)))
)

export const fetchReward = (id) => (dispatch) => (
  APIUtil.fetchReward(id).then((reward)=> dispatch(receiveReward(reward)))
)

export const createReward = (reward) => (dispatch) => (
  APIUtil.createReward(reward).then((reward) => dispatch(receiveReward(reward)))
)
export const updateReward = (reward) => (dispatch) => (
  APIUtil.updateReward(reward).then((reward) => dispatch(receiveReward(reward)))
)
