import React from 'react';

class RewardForm extends React.Component {
  constructor(props){
    super(props)

    this.state = props.reward
    // const routeNumber = parseInt(this.props.location.pathname.slice(10))
  }

  navigateToShow(){
    const routeNumber = parseInt(this.props.location.pathname.slice(10));
    this.props.history.push(`/projects/${routeNumber}`);
  }

  handleChange(e, input){
    const routeNumber = parseInt(this.props.location.pathname.slice(10))
    this.setState({
      [input]: e.target.value,
      project_id: routeNumber
    })
  }

  handleClick(e){
    e.preventDefault();
    this.props.createReward(this.state);
    this.navigateToShow();
  }


  render(){

    return(
      <div className="reward-form-container">
        <h2>
          Set your rewards
        </h2>
Invite backers to be a part of the creative experience by offering rewards like a copy of what you’re making, a special experience, or a behind-the-scenes look into your process.
       <form className="reward-form" onSubmit={(e)=>this.handleClick(e)}>
         <br />
         <div className="form-section">
           <label>Reward Title</label>
           <input className="reward-form-title"  type="text" value={this.state.title} placeholder="title" onChange={(e)=>this.handleChange(e, "title")}></input>
         </div>
         <br />
         <div className="form-section">
           <label>Reward Amount</label>
           <input className="reward-form-amount"  type="number" value={this.state.amount_met} placeholder="amount" onChange={(e)=>this.handleChange(e, "amount_met")}></input>
         </div>
         <br />
         <div className="form-section">
           <label>Reward Description</label>
           <input className="reward-form-description"  type="text" value={this.state.description} placeholder="description" onChange={(e)=>this.handleChange(e, "description")}></input>
         </div>
         <br />


         <input className="form-submission" type="submit" value="Set Your Reward"></input>
         </form>

      </div>
    )
  }
}

export default RewardForm;
