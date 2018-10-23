import * as ProjectAPIUtil from '../util/project_api_util';

export const RECEIVE_PROJECTS = "RECEIVE_PROJECTS";
export const RECEIVE_PROJECT = "RECEIVE_PROJECT";
export const REMOVE_PROJECT = "REMOVE_PROJECT";

export const receiveProjects = (projects) => ({
  type: RECEIVE_PROJECTS,
  projects
})

export const receiveProject = (project) => ({
  type: RECEIVE_PROJECT,
  project
})

export const removeProject = (projectId) => ({
  type: REMOVE_PROJECT,
  projectId
})


export const fetchProjects = () => (dispatch) => (
  ProjectAPIUtil.fetchProjects().then(proj => dispatch(receiveProjects(proj))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const fetchProject = (id) => (dispatch) => (
  ProjectAPIUtil.fetchProject(id)
  .then(proj => dispatch(receiveProject(proj))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const createProject = (project) => (dispatch) => (
  ProjectAPIUtil.createProject(project)
  .then(proj => dispatch(receiveProject(proj))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const updateProject = (project) => (dispatch) => (
  ProjectAPIUtil.updateProject(project)
  .then(proj => dispatch(receiveProject(proj))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const deleteProject = (projectId) => (dispatch) => (
  ProjectAPIUtil.deleteProject(projectId)
  .then(() => dispatch(removeProject(projectId))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)

export const fetchCategoryProjects = (categoryId) => (dispatch) => (
  ProjectAPIUtil.fetchCategoryProjects(categoryId)
  .then((projects) => dispatch(receiveProjects(projects))),
  err => (dispatch(receiveErrors(err.responseJSON)))
)
