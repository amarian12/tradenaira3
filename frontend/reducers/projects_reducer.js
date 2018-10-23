import { RECEIVE_PROJECTS, RECEIVE_PROJECT, REMOVE_PROJECT, removeProject, receiveProjects, receiveProject } from "../actions/project_actions";
import merge from 'lodash/merge';

const projectsReducer = (state = {}, action) => {
  Object.freeze(state);
  const newState = merge({}, state)
  switch(action.type){
    case RECEIVE_PROJECTS:
      return action.projects;
    case RECEIVE_PROJECT:
      newState[action.project.id] = action.project
      return newState;
    case REMOVE_PROJECT:
      delete newState[action.projectId]
      return newState
    default:
      return state;
  }
}

export default projectsReducer;
