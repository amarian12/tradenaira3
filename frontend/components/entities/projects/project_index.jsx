import React from 'react';
import ProjectIndexItem from './project_index_item';
import { Link } from 'react-router-dom';
import CategoryIndexBar from '../../category_index_bar';
import SplashVid from '../../../splash-video.js';
import ProjectIndexStats from './project_index_stats';
import Spinner from '../../spinner';
import { Spotlight } from './project_spotlight';


class ProjectIndex extends React.Component {
  constructor(props){
    super(props)
    this.state = {loading: true}
  }


  componentDidMount(){
    this.props.fetchProjects();
    this.props.fetchCategories();
  }

  componentWillReceiveProps(nextProps){
    if (this.props.categoryId && (this.props.categoryId !== nextProps.categoryId)){
      this.props.fetchCategoryProjects(this.props.categoryId);
    } else if (Object.keys(this.props.projects).length === 0) {
     this.props.fetchProjects();
    }
    setTimeout(() => this.setState({loading: false}), 850)
  }

  render () {
    // if (this.props.project === undefined) {
    //   return (
    //     <Spinner />
    //   );
    // }


    const category = this.props.categories;
    let totalProjects;
    let fundedProjects;
    if (this.props.projects){
      totalProjects = this.props.projects.length;
      fundedProjects = this.props.projects.filter(e=>e.total_amount > 0).length
    }

    if (this.state.loading){
      return (
      <Spinner />
      )
    } else {
    return (
      <div className="project-items">
        <ProjectIndexStats total={totalProjects}
                          funded={fundedProjects}/>
        <Spotlight props={this.props.projects} />
        <br />
        <div id="all-projects" className="all-projects-count">
          Showing <span style={{"color" : "#009e74"}}>{this.props.projects.length}</span> projects
        </div>
        <ul className="project-list">
          {
            this.props.projects.map(project=>
              <li key={project.id}>
                  <ProjectIndexItem
                    project={project}
                    category={category[(project.category_id-1)]}
                  />
              </li>
            )
          }
        </ul>
      </div>
    )
   }
  }
}


export default ProjectIndex;
