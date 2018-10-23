import React from 'react';
import { Link } from 'react-router-dom';

class SplashVid extends React.Component {
    constructor (props) {
        super(props);

        this.state = {
            videoURL: 'https://player.vimeo.com/external/121491313.hd.mp4?s=e01cd8f40d5e3cbe35f80f30900585f75d772839&profile_id=119&oauth2_token_id=57447761',
            clicked: 'on'
        }
        this.switchToLogin = this.switchToLogin.bind(this);
    }

    switchToLogin(e){
      if(this.state.clicked === 'on'){
        this.setState({
          clicked: 'off'
        });
      } else {
        this.setState({
          clicked: 'on'
        });
      };

    };

    render () {

      const clicked = this.state.clicked;
      const enterButton = (
        clicked === 'on' ?
        <div className="enter-button" onClick={(e)=>this.switchToLogin(e)}>
          <button type="submit" className="enter-button js-modal-login-open">Enter</button>
        </div> : ''
      );
      const welcome = (
        clicked === 'on' ?
        <div className="welcome-text" style={{ "zIndex": "3"}}>
          <h1>Bring your creative project to life.</h1>
          <br />
          {enterButton}
      </div> : ""
      );


        return (
          <div className="wrapper">
            <div id="logo-landing">KickSmarter</div>
              {welcome}
          <video className="background-video" loop autoPlay muted>
              <source src={this.state.videoURL} type="video/mp4" />
              <source src={this.state.videoURL} type="video/ogg" />
              Your browser does not support the video tag.
          </video>

        </div>
        )
    }
};

export default SplashVid;
