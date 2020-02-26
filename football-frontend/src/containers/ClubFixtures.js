import React from 'react'
import Fixture from '../components/Fixture'

class ClubFixtures extends React.Component {

    state = {  
        first: this.props.first
    }

    getFixtures = () => {
         if (this.props.clubinfo && this.state.team !== this.props.clubinfo.name) {
            fetch(`http://localhost:3000/games/${this.props.clubinfo.name}`)
            .then(resp => resp.json())
            .then(parsed => {this.setState({games: parsed, team: this.props.clubinfo.name})})
         }
    }

    renderFixture = () => {
        this.getFixtures()
        if (this.state.games) {
            return this.state.games.map((game) => {
                let keyid = Math.random()
                if (this.state.first) {
                    this.props.gameStatRender(game.home_team, game.away_team)
                    this.setState({first: false})
                }
                return <Fixture key={keyid} game={game} gameStatRender={this.props.gameStatRender}/>
            })
        }
    }

    renderHelper = () => {
        this.renderFixture()
    }

    render() {
        return(
            <div id="ClubFixturesContainer">
            <div id="ClubFixtures">
                <div id="ClubFixturesHeader" ><img id="ClubFixturesHeaderImage" src="https://cdn.freebiesupply.com/images/large/2x/premier-league-logo-black-and-white.png" alt="Premier League Logo"/></div>
                <div id="FixtureList">
                    <table cellPadding="4" cellSpacing="0">
                        <thead>
                            <tr className="TableHeader">
                                <th>Date</th>
                                <th>Home Team</th>
                                <th></th>
                                <th>Away Team</th>
                            </tr>
                        </thead>
                        <tbody>
                            {this.renderFixture()}
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="ClubFixtureListTransient"></div>
            </div>
        )
    }
}

export default ClubFixtures