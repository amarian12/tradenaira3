import React from 'react';
import { Link, Route } from 'react-router-dom';
import ProjectFormContainer from './project_form_container';
import RewardIndexContainer from '../rewards/reward_index_container';
import PledgeFormContainer from '../pledges/pledge_form_container';
import Spinner from '../../spinner';


class ProjectShow extends React.Component {

  componentDidMount(){
    this.props.fetchProject();
    this.props.fetchRewards();
    // this.props.fetchProjects()
    this.props.fetchCategories();
  }

  componentWillReceiveProps(nextProps){
    if (this.props.location.pathname !== nextProps.location.pathname){
      this.props.fetchProject()
      this.props.fetchRewards()
      this.props.fetchProjects()
      this.props.fetchCategories()
    }
  }

  backToIndex(){
    this.props.history.push('/');
  }

  update(){
    this.props.updateProject()
  }

  handleDel(){
    confirm("Do you want to delete this project?")
    this.props.deleteProject(this.props.project.id);
    this.backToIndex();
  }


  render(){
    const user = this.props.user;
    const project = this.props.project;

    if (project === undefined) {
      return (
        <Spinner />
      );
    }



    const author = <p className="show-author"><img className="author-avatar" src="https://ksr-ugc.imgix.net/missing_user_avatar.png?w=40&h=40&fit=crop&v=&auto=format&q=92&s=8c0db61c92692000c2678b375fc31714"/> <br /> by {project.author}</p>

    const updateButton = (user && user.id === project.user_id ? <Link to={`/projects/${project.id}/edit`}><button className="update-btn" type="submit" value="Update Project">Update</button></Link> : <div><br /></div>)

    const deleteButton = (user && user.id === project.user_id ? <button className="delete-btn" onClick={()=> this.handleDel()}>Delete</button> : "")



    return (
      <div className="show-page">
        <br />
        <div className="show-header">
          <div className="show-author-container">
            {author}
            <div className="show-user-edit">
                {deleteButton}
                {updateButton}
            </div>
          </div>
          <div className="header-description">
            <h2 className="show-title">{project.title}</h2>
            <p className="show-blurb">{project.blurb}</p>
          </div>
        </div>

        <br />
        <div className="show-container">
          <div className="show-pic-div">
            <img className="show-pic" src={project.image_url}/>
          </div>
          <div className="show-description">
            <p>Description: <br /><br />{project.description}</p>
          </div>
        </div>

        <div className="show-pledge-container">
          <div id="top" className="show-pledge-stats">
            <PledgeFormContainer/>
          </div>
          <div className="description-reward-box">
            <div>

            </div>
          </div>
        </div>
      </div>

    )
  }
}

export default ProjectShow;
