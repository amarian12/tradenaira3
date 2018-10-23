import React from 'react';
import { Link, Redirect } from 'react-router-dom';
import Dropzone from 'react-dropzone';
import request from 'superagent';
import RewardFormContainer from '../rewards/reward_form_container';

const APIKey = '863179187869473';
const imageUpload = 'https://api.cloudinary.com/v1_1/dqfxil15q/image/upload';
const uploadPreset = 'bzskthjb';

class ProjectForm extends React.Component {
  constructor(props){
    super(props)

    this.state = props.project;
    this.navigateToIndex = this.navigateToIndex.bind(this);
    this.navigateToShow = this.navigateToShow.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.scrollToRewards = this.scrollToRewards.bind(this);
    this.scrollToUpdate = this.scrollToUpdate.bind(this);
    this.swapForm = this.swapForm.bind(this);
    this.handleImageUpload = this.handleImageUpload.bind(this);
  }

  componentDidMount(){
    if(this.props.match.params.projectId){
      this.props.fetchProject(this.props.match.params.projectId)
    }
  }

  navigateToIndex(){
    this.props.history.push('/');
  }

  navigateToShow(){
    this.props.history.push(`/projects/${this.props.project.id}`);
  }

  handleChange(e, input){
    this.setState({
      [input]: e.target.value
    })
  }

  handleClick(e){
    e.preventDefault();
    // console.log(this.props)
    this.props.project.author = this.props.user.username
    this.setState({
      author: this.props.user.username,
      user_id: this.props.user.id
    })
    // console.log(this.state)
    if(this.props.formType === 'new'){
      this.props.createProject(this.state);
      this.navigateToIndex();
    } else {
      this.props.updateProject(this.state)
      this.navigateToShow();
    }
  }

  uploadedPhoto() {
   if (this.state.image_url === '') {
     return (

       <div className="drop-text"> Drop an image or click to select a file to upload.</div>
     );
   } else {
     return (
       <img className='form-photo-thumbnail' src={this.state.image_url}></img>
     );
   }
 }
  swapForm(e){
    e.preventDefault()
    const correctForm = (
      this.state.form === 1 ?  2 : 1
    )
    this.setState({
      form: correctForm
    })
  }


  scrollToUpdate(e){
    e.preventDefault;
    window.scrollTo(0,250);
  };

  scrollToRewards(e){
    e.preventDefault;
    window.scrollTo(0,document.body.scrollHeight);
  };

  handleImageUpload(file) {
    let upload = request.post(imageUpload)
    .field('upload_preset', uploadPreset)
    .field('file', file);
    upload.end((err, response) => {
      if (response.body.secure_url !== '') {
        this.setState({
          image_url: response.body.secure_url
        });
      }
    });
  }

  render(){
    // console.log(this.props);
    const project = this.state
    const setRewards = (
      this.props.formType === 'new' ?   "" : <RewardFormContainer />
    )
    const setBlurb = (
      this.props.formType === 'new' ?
    <div className="form-greeting">
      <h2>
        Hello, {this.props.user.username}!
        Let's get started.
      </h2>
      <h4>Make a great first impression with your project's title and image, and set your funding goal, campaign end date, and project category</h4>
    </div> :
    <div className="form-greeting">
      <h2>
        Hello, {this.props.user.username}!
        Welcome back.
      </h2>
      <h4>Make some changes to your project or create new rewards</h4>
      <button className="form-btn" onClick={(e)=>this.scrollToUpdate(e)}>Update Form</button>
      <button className="form-btn" onClick={(e)=>this.scrollToRewards(e)}>Create Rewards</button>
    </div>
  )
  project.author = this.props.user.username
 const text = this.props.formType === 'new' ? "Create Project" : "Update Project";
    const setUpdate = (

      <form className="project-form" onSubmit={(e)=>this.handleClick(e)}>
        <br />
        <div className="form-section">
          <label>Project Title</label>
          <br />
          <input className="form-title" value={project.title} type="text" placeholder="Create a title"  onChange={(e)=>this.handleChange(e, "title")}></input>
        </div>
        <br />
        <div className="form-section">
          <label>Blurb</label>
          <input className="form-blurb" value={project.blurb} type="text" placeholder="Make a quick blurb"
            onChange={(e)=>this.handleChange(e, "blurb")}></input>
        </div>
        <br />
        <div className="form-section">
          <label>Description</label>
          <textarea className="form-description" value={project.description} type="text" cols="78" rows="10" placeholder="Tell us more"
            onChange={(e)=>this.handleChange(e, "description")}></textarea>
        </div>
        <br />
        <div className="form-section">
          <label>Project End Date</label>
          <input className="form-end_date" value={project.end_date} type="text" placeholder="X/XX/XXXX" onChange={(e)=>this.handleChange(e, "end_date")}></input>
        </div>
        <br />
          <div className="form-section">
        <label>Funding Goal</label>
        <input className="form-funding_goal" value={project.funding_goal} type="number" placeholder="funding goal" onChange={(e)=>this.handleChange(e, "funding_goal")}></input>
        </div>
        <br />
          <div className="form-section">
        <label>Image URL</label>
        <div className="form-pic-inputs">
          <Dropzone
            className="dropzone-div"
            multiple={false}
            accept="image/*"
            onDrop={this.handleImageUpload}>
            {this.uploadedPhoto()}
          </Dropzone>
          <input className="form-image_url" value={project.image_url} type="text" placeholder="Or copy paste URL. (example: https://www.favpic.com/mypic/pic.jpg)" onChange={(e)=>this.handleChange(e, "image_url")}></input>
        </div>
        <br />
        </div>
       <input className="form-submission" type="submit" value={text}></input>
     </form>
    )
    // console.log(this.props.formType)


    return(
      <div className="project-form-container">
        {setBlurb}
        <div id="update">
          {setUpdate}
        </div>
        <br />
        <br />
        <br />
        <br />
        <div id="rewards">
          {setRewards}
        </div>
      </div>
    )
  }
}

export default ProjectForm;
