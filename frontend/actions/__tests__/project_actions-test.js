import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import * as actions from '../project_actions';
import * as ApiUtil from '../../util/project_api_util';

import { testProjects } from '../../testUtil/project_helper';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);

describe('actions', () => {
  test('receiveProjects should create an action to receive projects', () => {
    // refer to https://redux.js.org/docs/recipes/WritingTests.html
    const projects = {
      type: actions.RECEIVE_PROJECTS,
      projects: testProjects
    }
    expect(actions.receiveProjects(testProjects)).toEqual(projects)
  });
});

// describe('async actions', () => {
//
//   test('fetchProjects creates RECEIVE_PROJECTS after fetching projects', () => {
//     // REFER TO REDUX TESTS DOCS
//     // Set up expectedActions:
//     // Your code here
//     const expectedActions = [
//       {
//         type: actions.RECEIVE_PROJECTS,
//         projects: testProjects
//       }
//     ];
//
//     ApiUtil.fetchProjects = jest.fn(() => {
//       return Promise.resolve(testProjects);
//     });
//
//     const store = mockStore({ projects: {} });
//     // return store.dispatch(actions.fetchBenches()).then(() => {
//     //   expect(store.getActions()).toEqual(expectedActions);
//     // });
//     return store.dispatch(actions.fetchProjects()).then(() => {
//       expect(store.getActions()).toEqual(expectedActions)
//     });
//   });
// });


// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/resolve
// Explanation of what Promise.resolve does:

// var promise1 = Promise.resolve([1, 2, 3]);

// promise1.then(function (value) {
//   console.log(value);
//   // expected output: Array [1, 2, 3]
// });
