import React from 'react';
import './App.css';
import Navbar from './containers/Navbar'
import LiveScoreContainer from './containers/LiveScoreContainer'
import ClubPage from './containers/ClubPage'
import HomePage from './containers/HomePage'

class App extends React.Component {

  state = {
    render: "home"
  }
  
  teamChooser = (teamName) => {
    this.setState({chosenTeam: teamName, render: "club"})
  }

  goHome = () => {
    this.setState({render: "home"})
  }

  pageRender = () => {
    switch (this.state.render) {
      case "club":
        return <ClubPage chosenTeam={this.state.chosenTeam} />
      case "home":
        return <HomePage home={this.state.render} />
      default:
        break;
    }
  }

  render() {
  return (
    <div className="App">
      <Navbar teamChooser={this.teamChooser} goHome={this.goHome}/>
      <div className="LayoutGrid">
        {/* <NavColumn goHome={this.goHome} /> */}
        {this.pageRender()}
      </div>
      <LiveScoreContainer />
    </div>
  );
  }
}

export default App;
