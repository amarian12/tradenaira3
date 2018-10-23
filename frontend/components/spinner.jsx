import React from 'react';
import { RingLoader, BarLoader, BeatLoader } from 'react-spinners';

class Spinner extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: true
    }
  }
  render() {
    return (
      <div className='sweet-loading'>
        <BarLoader
          color={'#50AC54'}
          loading={this.state.loading}
          width={4000}
        />
      </div>
    )
  }
}

export default Spinner
