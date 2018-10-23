import * as APIUtil from '../util/pledge_util';

export const RECEIVE_PLEDGE = "RECEIVE_PLEDGE";

export const receivePledge = (pledge) => ({
  type: RECEIVE_PLEDGE,
  pledge
});

export const createPledge = (pledge) => (dispatch) => (
  APIUtil.createPledge(pledge).then((pledge)=> dispatch(receivePledge(pledge)))
)
