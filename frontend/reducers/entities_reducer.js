import { combineReducers } from 'redux';

import projectsReducer from './projects_reducer';
import rewardsReducer from './rewards_reducer';
import pledgeReducer from './pledge_reducer';
import searchReducer from './searches_reducer';
import categoryReducer from './category_reducer';

export default combineReducers({
  categories: categoryReducer,
  pledges: pledgeReducer,
  projects: projectsReducer,
  rewards: rewardsReducer,
  searches: searchReducer
})
