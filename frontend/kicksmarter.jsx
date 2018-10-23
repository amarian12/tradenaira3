import React from 'react';
import ReactDOM from 'react-dom';
import { login, logout, signup } from './util/session_api_util';
import configureStore from './store/store';
import Root from './components/root';
import { fetchProjects, createProject, fetchProject, deleteProject, fetchCategoryProjects } from './actions/project_actions';
// import * as APIUtil from './util/category_util';
import { createReward, updateReward, fetchRewards } from './actions/reward_actions';
import { fetchCategory, fetchCategories } from './actions/category_actions';
import { searchDatabase } from './actions/search_actions';
import {createPledge} from './util/pledge_util';



document.addEventListener('DOMContentLoaded', ()=> {
  let store;
  if (window.currentUser) {
    const preloadedState = { session: { currentUser: window.currentUser } };
    store = configureStore(preloadedState);
    delete window.currentUser;
  } else {
    store = configureStore();
  }


  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root)
})
