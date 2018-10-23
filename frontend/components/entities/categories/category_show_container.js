import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import CategoryShow from './category_show';
import { fetchCategories, fetchCategory } from '../../../actions/category_actions';
import { fetchProject, fetchProjects, fetchCategoryProjects } from '../../../actions/project_actions';

const mapStateToProps = (state, ownProps) => {
  const category = state.entities.categories[ownProps.match.params.id]
  const projects = Object.values(state.entities.projects)
  const categoryId = parseInt(ownProps.location.pathname.split("/").slice(-2)[0])

  const categoryProjects = projects.map((e)=>
     e.category_id === categoryId ? e : ""
  ).filter(c => c !== "")


  return {
    category,
    categoryProjects
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchCategory: (id) => dispatch(fetchCategory(id)),
    fetchProjects: () => dispatch(fetchProjects()),
    fetchCategoryProjects: (categoryId) => dispatch(fetchCategoryProjects(categoryId)),
    fetchCategories: () => dispatch(fetchCategories())
  }
}


export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(CategoryShow))
