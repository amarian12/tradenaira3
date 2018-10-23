import React from 'react';

class RewardIndex extends React.Component {
  constructor(props){
    super(props)
    this.state = props.project

    if (this.state.total_amount === null || this.state.total_amount === NaN){
      this.state.total_amount = 0
    }
  }

  componentDidMount(){
    // this.props.fetchRewards()
  }
  //
  // componentWillUpdate(nextProps, nextState){
  //   if(nextProps.project.total_amount !== nextState.total_amount){
  //     this.props.updateProject(this.state)
  //   }
  // }

  handleChange(e){
    e.preventDefault()

    const addToPledge = parseInt(e.target.value) + parseInt(this.state.total_amount)

    this.setState({
      total_amount: addToPledge
    })

  }

  handleClick(e){
    e.preventDefault()
    if (this.props.user){
    //   const addToPledge = parseInt(e.target.value) + parseInt(this.state.total_amount)
    //   console.log("added", addToPledge)
    // // //   c
    // const addToPledge = parseInt(e.target.value) + parseInt(this.state.total_amount)
    // this.setState({
    //   total_amount: addToPledge
    // })
    //
    //   this.setState({
    //     total_amount: addToPledge
    //   })
      this.props.updateProject(this.state);
      // console.log("should be update", this.state.total_amount)
    } else {
      alert("User is not logged in")
    }
    // console.log("clicked", e.target.value)
    // this.props.createPledge(this.state);
  }

//send reward amount to the placeholder


  render(){
    // console.log("reward index state", this.state)
    // console.log("reward index props", this.props)
    const rewards = this.props.rewards.map(e=>(
      <div className="show-reward"
        key={`${e.title}-${e.id}`}>
         <h3>Pledge ${e.amount_met} or more</h3>
         <button onClick={e=>this.handleClick(e)} className="reward-btn js-modal3-open">Support</button>
         <h4>{e.title}</h4>
         <p className="pledge-text-grey">{e.description}</p>
      </div>
      )
    )

    return (
      <div>
        {rewards}
      </div>
    )
  }
}

export default RewardIndex;
