import React from 'react'
import ClubFixtures from './ClubFixtures'
import StatContainer from './StatContainer'


class FixtureAndStatContainer extends React.Component {

    state = {
        // home_team: "Liverpool FC",
        // away_team: "Everton FC"
    }

    gameStatRender = (home_team, away_team) => {
        this.setState({home_team: home_team, away_team: away_team})
    }

    statRender = () => {
        if (this.state.home_team && this.state.away_team) {
            let keynum = Math.random()
            return <StatContainer key={keynum} home_team={this.state.home_team} away_team={this.state.away_team} first={true}/>
        }
    }

    render() {
        return(
            <div id="FixtureAndStatContainer">
                <ClubFixtures clubinfo={this.props.clubinfo} gameStatRender={this.gameStatRender}/>
                {this.state.home_team && this.state.away_team? this.statRender() : <h1 id="StatHeader">Click A Fixture From The List of Fixtures to the Left</h1>}
            </div>
        )
    }
}

export default FixtureAndStatContainer