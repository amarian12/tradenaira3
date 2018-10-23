import React from 'react';
import RewardIndexContainer from '../rewards/reward_index_container'

class PledgeForm extends React.Component {
  constructor(props){
    super(props)

    this.state = props.project

    this.navigateToShow = this.navigateToShow.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.updatedAmt = this.updatedAmt.bind(this);

    if (this.state.total_amount === null || this.state.total_amount === NaN){
      this.state.total_amount = 0
    }
  }

  componentWillReceiveProps(nextProps){

  }
  //
  componentWillUpdate(nextProps, nextState){
    if(nextProps.project.total_amount !== nextState.total_amount){
      this.props.updateProject(this.state)
    }
  }

  handleChange(e, input){
    e.preventDefault()
    this.props.amount[input] = e.target.value
    this.props.amount['percentage'] = Math.round((this.props.project.total_amount/this.props.project.funding_goal) * 100)
  }

  navigateToShow(){
    this.props.history.push(`/projects/${this.props.project.id}`);
  }

  getForm(){
    let submitForm = (
        <form onClick={(e)=>this.handleClick(e)}>
          <input type="number" placeholder={0} value={this.state.amount_pledged} onChange={e=>this.handleChange(e, "amount_pledged")}></input>
          <br />
          <input id="try" className="pledge-button"  type="submit" value="Support this project" style={{ 'fontSize': '20px'}} />
        </form>
      )
      
    return submitForm;
  }

  handleClick(e){
    e.preventDefault()
    if (this.props.user){
      this.setState({
        total_amount: this.updatedAmt(),
      })
      this.props.amount['percentage'] = parseInt(Math.round((this.state.total_amount/this.state.funding_goal) * 100))
      this.props.updateProject(this.state);
      this.props.amount['amount_pledged'] = 0
    } else {
      alert("User is not logged in")
    }
    // this.props.createPledge(this.state);
  }

  updatedAmt(){
    return parseInt(this.props.amount['amount_pledged']) + parseInt(this.state.total_amount)

  }

  clickForm(input){
    var formIsClicked;
    formIsClicked = input
  }
  render(){
    //make alternating click then morph to buttons
    //make alternating if props.amount = 0 do this other wise, use filtered rewards.amount_met and turn that into amount[amount pledged]
    //confirm payment before making it.
    // make payment redirect page


    const project = this.props.project;
    // console.log(project)
    const relevantRewards = this.props.filteredRewards;
    const currentAmountPledged = project.amount_pledged;
    const percentage = (this.state.total_amount/this.state.funding_goal) * 100
    const percentageBar = percentage <= 100 ? <div className="percentage-bar" style={{ 'width': `${percentage}%`}}></div> : <div className="percentage-bar" style={{ 'width': `100%`}}></div>


    // $("#try").on(this.getForm())
    // console.log("we clicked yes?", formIsClicked)

    //
    let formIsClicked = true;
    let submitForm = (
      <form onClick={(e)=>this.handleClick(e)}>
        <div className="pledge-input-box">
          <input className="pledge-input" type="number" placeholder={0} value={this.state.amount_pledged} onChange={e=>this.handleChange(e, "amount_pledged")}></input>
          <a href="#top"><input className="modal2-close js-modal2-close js-modal3-close" type="submit" value="Confirm" style={{ 'fontSize': '20px'}}/></a>
        </div>
      </form>
    )


  // console.log("pledge form", this.props)

  return (
      <div className="pledge-box">
        {percentageBar}

        <div className="percentage-bar-empty"></div>
        <p className="show-amount-raised" style={{ }}>${this.state.total_amount}</p>
        <div className="pledge-text-grey"><p>Amount pledged of ${project.funding_goal} goal</p>
        <p><span style={{ 'fontSize': '25px', 'color':'black' }}> {Math.floor(percentage)}%</span> funded</p>
        </div>

        <p className="show-end_date">{project.end_date}</p>
        <p className="pledge-text-grey">Project End Date</p>

      <input className="pledge-button js-modal2-open"  type="submit" value="Support this project" style={{ 'fontSize': '20px'}}/>

        <div className="modal2">
          <div className="modal2-div">
              {submitForm}
          </div>
        <div className="modal2-screen js-modal2-close"></div>
        </div>

        <br />
          <p className="all-or-nothing">All or nothing. This project will only be funded if it reaches its goal by {project.end_date} 10:00 AM PST.</p>
          <br />

          <div className="modal3">
            <div className="modal3-div">
                {submitForm}
            </div>
          <div className="modal3-screen js-modal3-close"></div>
          </div>

          <RewardIndexContainer props={this.props} />



      </div>
    )
  }
}

export default PledgeForm;
